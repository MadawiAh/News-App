//
//  Validators.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/01/1444 AH.
//

import Foundation

class Validator {
    
    static func validateEmail(_ email: String) -> String?{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty {
            return "Field required"
        }
        
        if !emailPred.evaluate(with: email){
            return "Invalid Email Address"
        }
        return nil
    }
    
    static func validatePassword(_ password: String) -> String?{

        if password.isEmpty {
            return "Field required"
        }
        if password.count < 6{
            return "Use at least 6 characters"
        }
        if password.range(of: #"\p{Alphabetic}+"#, options: .regularExpression) == nil {
            return "Use at least one letter"
        }
        if password.range(of: #"\d+"#, options: .regularExpression) == nil {
            return "Use at least one digit"
        }
        if password.range(of: #"(?=.*[A-Z])"#, options: .regularExpression) == nil{
            return "Use at least one capital letter"
        }
        if password.range(of: #"\s+"#, options: .regularExpression) != nil {
            return "Avoid using whitespace"
        }
        return nil
    }

}
