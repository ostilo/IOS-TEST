//
//  GetPostResponse.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import UIKit
import RealmSwift

class GetPostResponse: Object, Decodable {
    @objc dynamic var  title: String?
    @objc dynamic var body: String?
}

class AllPostRetrived: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var postList: List<GetPostResponse>
}






