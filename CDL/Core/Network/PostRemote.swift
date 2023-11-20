//
//  PostRemote.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import Foundation
import RealmSwift

class PostRemote : NetworkService{
    
    let realmId = try! Realm()
    var tasks = AllPostRetrived()
    
    init() {
        super.init(baseUrl: "")
    }
    
    func getPostData(runCompletionOnUIThread: Bool, completion: @escaping(Result<[GetPostResponse], Error>) -> Void){
        self.request(route: Route.post, method: Method.get, runCompletionOnUIThread: runCompletionOnUIThread) {
            (result: Result<[GetPostResponse], Error>) in
            switch(result) {
            case .success(let response):
                completion(.success(response))
                do {
                    //self.tasks.id = UUID().uuidString
                    try! self.realmId.write {
                        self.tasks.postList.append(objectsIn: response)
                        self.realmId.add(self.tasks, update: .all)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    print("ERROR AGAIN")
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}

