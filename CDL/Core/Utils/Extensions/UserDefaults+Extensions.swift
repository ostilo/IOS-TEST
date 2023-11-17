//
//  UserDefaults+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case userHasBeenOnboarded
        case userDets
    }
    
    var userHasBeenOnboarded: Bool {
        get {
            bool(forKey: UserDefaultsKeys.userHasBeenOnboarded.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultsKeys.userHasBeenOnboarded.rawValue)
        }
    }
    
    var user: User? {
        get {
            if let data = object(forKey: UserDefaultsKeys.userDets.rawValue) as? Data{
               return try? JSONDecoder().decode(User.self, from: data)
            }else{
                return nil
            }
        }
        
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                setValue(encoded, forKey: UserDefaultsKeys.userDets.rawValue)
            }
        }
    }
    

    
}
