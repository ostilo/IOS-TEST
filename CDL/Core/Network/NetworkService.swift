//
//  NetworkService.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import Foundation

class NetworkService {
    
    private let baseUrl: String?
    
    init(baseUrl: String? = nil) {
        self.baseUrl = baseUrl
    }
    
    
    func reRequest<QueryParams: Encodable, RequestBody: Encodable, ResponseBody: Decodable>(
        route: Route,
        method: Method,
        queryParameters: QueryParams? = nil as String?,
        requestBody: RequestBody? = nil as String?,
        runCompletionOnUIThread: Bool,
        completion: @escaping(Result<ResponseBody, Error>) -> Void
    ){
        request(route: route, method: method, queryParameters: queryParameters?.toDict(), requestBody: requestBody?.toDict(), runCompletionOnUIThread: runCompletionOnUIThread, completion: completion)
    }
    
    /// This function makes an API request.
    /// - Parameters:
    ///   - route: The path the the resource in the backend.
    ///   - method: Type of request to be made.
    ///   - queryParameters: Query parameters you need to pass to the backend.
    ///   - requestBody: Request body you need to pass to the backend.
    ///   - runCompletionOnUIThread: Boolean indicating whether the completion handler should be run on the UI or background thread.
    ///   - completion: The completion handler to call, passing along the response status and response data.
    /// - Returns: URLRequest
    func request<T: Decodable>(
        route: Route,
        method: Method,
        headers: [String: String]? = nil,
        queryParameters: [String: Any]? = nil,
        requestBody: [String: Any]? = nil,
        runCompletionOnUIThread: Bool,
        completion: @escaping(Result<T, Error>) -> Void
    ) {
        guard let request = createRequest(route: route, method: method, headers: headers, queryParameters: queryParameters, requestBody: requestBody) else {
            completion(.failure(CDLError.unknownError))
            return
        }
        
        print(request.httpMethod)
        print(request.url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.runInBackgroundOrUIThread(runOnUIThread: runCompletionOnUIThread) {
                if let data = data {
                    let stringifiedResponse = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                    print(stringifiedResponse)
                } else {
                    print("No data returned")
                }
                self.handleResponse(response: response, data: data, completion: completion)
            }
        }.resume()
    }
    
    /// This function generates a urlRequest.
    /// - Parameters:
    ///   - route: The path the the resource in the backend.
    ///   - method: Type of request to be made.
    ///   - bearerToken: The bearer token for API access. Usually access token or a secret/public key. 'Bearer' is added for you so you need only provide the key/token.
    ///   - queryParameters: Query parameters you need to pass to the backend.
    ///   - requestBody: Request body you need to pass to the backend.
    /// - Returns: URLRequest
    private func createRequest(route: Route,
                               method: Method,
                               bearerToken: String? = nil,
                               headers: [String: String]? = nil,
                               queryParameters: [String: Any]? = nil,
                               requestBody: [String: Any]? = nil) -> URLRequest? {
        let urlString = (baseUrl ?? "") + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let bearerToken = bearerToken {
            urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let headers = headers {
            let keys = Array(headers.keys)
            let values = Array(headers.values)
            
            for i in 0...keys.count - 1 {
                urlRequest.addValue(values[i], forHTTPHeaderField: keys[i])
            }
        }
        
        if let parameters = queryParameters {
            var urlComponent = URLComponents(string: urlString)
            urlComponent?.queryItems = parameters.map {
                let value = $1
                if value is Bool {
                    if (value as! Bool) {
                        return URLQueryItem(name: $0, value: "true")
                    }else{
                        return URLQueryItem(name: $0, value: "false")
                    }
                }else{
                    return URLQueryItem(name: $0, value: "\($1)")
                }
            }
            urlRequest.url = urlComponent?.url
        }
        
        if let body = requestBody {
            let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
            urlRequest.httpBody = bodyData
        }
        
        return urlRequest
    }
    
    /// This function converts any class that comforms to the Codable protocol to a dictionary, which can then be used to make API requests
    func codableClassToDict<RequestModel: Encodable>(model: RequestModel?) -> [String : AnyObject]? {
        var object: [String : AnyObject] = [String : AnyObject]()
        do {
            if let dataFromObject = try? JSONEncoder().encode(model) {
                object = try JSONSerialization.jsonObject(with: dataFromObject, options: []) as! [String : AnyObject]
            }
        } catch (let error) {
            print("\nError Encoding Parameter Model Object \n \(error.localizedDescription)\n")
        }
        return object
    }

    
    /// This function handles responses gotten from the server, calling the completion handler when it is done. This function is tuned to be friendlier to the error data model used in the TShip API by decoding the error data with TShipResponseWithoutData struct so it is easier to get and pass along the error messages from BAD_REQUESTs(400) since the data it returns is not consistent and is not being used for now.
    /// - Parameters:
    ///   - response: The response  gotten from running URLSession.dataTask or .data.
    ///   - data: Data gotten from running URLSession.dataTask or .data.
    ///   - completion: The completion handler to call, passing along the response status and response data.
    private func handleResponse<T: Decodable>(response: URLResponse?, data: Data?,
                                              completion: (Result<T, Error>) -> Void) {
        guard let response = response else {
            completion(.failure(CDLError.unknownError))
            return
        }
        
        switch((response as? HTTPURLResponse)?.statusCode){
        case HttpStatusCode.OK.rawValue, HttpStatusCode.CREATED.rawValue:
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let decoded = try decoder.decode(T.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
                
                guard let response = try? decoder.decode(T.self, from: data) else {
                    completion(.failure(CDLError.errorDecoding))
                    return
                }
                completion(.success(response))
            }else{
                completion(.failure(CDLError.unknownError))
            }
            
        case HttpStatusCode.BAD_REQUEST.rawValue:
            completion(.failure(CDLError.unknownError))
        default:
            completion(.failure(CDLError.unknownError))
        }

    }
    
    func runInBackgroundOrUIThread(runOnUIThread: Bool, toRun: @escaping() -> Void){
        if runOnUIThread {
            DispatchQueue.main.async {
                toRun()
            }
        }else{
            toRun()
        }
    }
    
    
}


