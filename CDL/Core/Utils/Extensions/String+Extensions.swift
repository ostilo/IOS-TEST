//
//  String+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import Foundation
import UIKit
import RealmSwift

extension RealmCollection
{
  func toArray<T>() ->[T]
  {
    return self.compactMap{$0 as? T}
  }
}

extension String {
    
    func toURL() -> URL? {
        return URL(string: self) //?? URL(string: "")!
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getInitials() -> String {
        let splitArray = components(separatedBy: " ")
        var initials: String = String(splitArray[0].first!)
        if splitArray.count > 1 {
            initials += String(splitArray[1].first!)
        }
        return initials.uppercased()
    }
    
    func getNameComponents() -> [String] {
        let comps = components(separatedBy: " ")
        if comps.count != 2 {
            return []
        }else{
            return comps
        }
    }
    
    func copyToClipboard(){
        UIPasteboard.general.string = self
    }
    
    // Code generated by OpenAI's GPT-3.5 model.
    // Capitalizes the first character of a string while preserving the rest of the string.
    func capitalizeFirstCharacter() -> String {
        guard let firstChar = first else {
            return self
        }
        
        let capitalizedFirstChar = String(firstChar).capitalized
        let restOfString = dropFirst()
        
        return capitalizedFirstChar + restOfString
    }
    
    func getFirstNumOfChars(num: Int) -> String {
        let startIndex = startIndex
        let endIndex = index(startIndex, offsetBy: num)

        return String(self[startIndex..<endIndex])
    }
    
    ///Initializes a URL with the String
    var asUrl: URL? {
        return URL(string: self)
    }
}


extension String? {
    
    func safe() -> String {
        self ?? ""
    }
    

    
}


extension Encodable {
    
    /// This function converts any class that comforms to the Encodable protocol to a dictionary, which can then be used to make API requests
    func toDict() -> [String : AnyObject] {
        var object: [String : AnyObject] = [String : AnyObject]()
        do {
            if let dataFromObject = try? JSONEncoder().encode(self) {
                object = try JSONSerialization.jsonObject(with: dataFromObject, options: []) as! [String : AnyObject]
            }
        } catch (let error) {
            print("\nError Encoding Parameter Model Object \n \(error.localizedDescription)\n")
        }
        return object
    }
    
  
 
}
