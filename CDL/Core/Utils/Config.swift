//
//  Config.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import Foundation
import KeychainAccess
import Firebase

enum Config {
    
    static func stringValue(forKey key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String
        else {
            fatalError("Invalid value or undefined key")
        }
        return value
    }
    
    static func boolValue(forKey key: String) -> Bool {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? Bool
        else {
            fatalError("Invalid value or undefined key")
        }
        return value
    }
    
    static func cdlPostAPIBaseUrl() -> String {
        return stringValue(forKey: "CDL_POST_API_BASE_URL")
    }
    
    static func environmentIs() -> EnvironmentIdentifier {
        return EnvironmentIdentifier(rawValue: stringValue(forKey: "ENVIRONMENT_IS")) ?? .unknown
    }
    
    static func logUserOut(){
        UserDefaults.standard.user = nil
        do {
            try Auth.auth().signOut()
        } catch let err {
            print(err)
        }
    }
    
    static func isRelease() -> Bool {
        return environmentIs() == .release
    }
    
    static func getFirebaseConfigPath() -> String? {
        return Bundle.main.path(forResource: "GoogleService-Info-\(environmentIs().rawValue)", ofType: "plist")
    }
}
