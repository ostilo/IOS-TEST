//
//  User.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import Foundation

struct User : Codable{
    
    let firstName:String
    
    let lastName:String
    
    let email:String
    
}

struct CreatePersonalRequest: Encodable {
    
    let email: String
    
    let fullName: String
    
    let password: String
   
    
}


