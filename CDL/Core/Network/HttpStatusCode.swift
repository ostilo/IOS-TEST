//
//  HttpStatusCode.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import Foundation


/// Enum representing the Http Status codes received and handled from  the API.
enum HttpStatusCode: Int {
    
    /// Status code returned when the API operation was successfull.
    case OK = 200
    
    /// Status code returned when the API create operation was successfull.
    case CREATED = 201
    
    /// Status code returned when the request sent to the API is not valid.
    case BAD_REQUEST = 400
}

/// Enum representing the different Http methods used to make API calls.
enum Method: String {
    case get = "GET"
}

enum Route {
    /// Base Url for the CDL Africa API
    static let baseUrl = ""
    static let cdlAPIBaseUrl = Config.cdlPostAPIBaseUrl()
    
    case post
    
    /// String representation of the route
    var description: String {
        switch self {
        case .post:
            return Route.cdlAPIBaseUrl + "/posts"
        }
    }
}

/// Enum representing the different types of error that occurs.
enum CDLError: LocalizedError {
    
    case errorDecoding
    
    case unknownError
    
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "An unknown error occurred. Please try again."
        case .serverError(let error):
            return error
        }
    }
    
}

