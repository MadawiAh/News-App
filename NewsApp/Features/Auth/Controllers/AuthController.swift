//
//  AuthController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 13/01/1444 AH.
//

import Foundation

class AuthController {
    
    enum authResult {
        case success
        case fail (dueTo: registrationFail)
    }
    
    enum registrationFail {
        case invalidCredentials
        case emailExists
        case passwordMismatch
    }
    
    
    func register(email: String, password: String, rePassword: String,  completion:  @escaping (authResult) -> Void){
        
        // 1.Check email existence
        if let currentUserEmail = UserDefaults.standard.string(forKey:"email"){
            if currentUserEmail.caseInsensitiveCompare(email) == ComparisonResult.orderedSame {
                completion(.fail(dueTo: .emailExists))
                return
            }
        }
        // 2.Check passswords match
        if password != rePassword {
            completion(.fail(dueTo: .passwordMismatch))
            return
        }
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(true, forKey: "isLogged")
        completion(.success)

    }
    
    func logIn(email: String, password: String,  completion:  @escaping (authResult) -> Void) {
        
        if let currentUserEmail = UserDefaults.standard.string(forKey:"email"),  let currentUserPassword = UserDefaults.standard.string(forKey:"password"){
            
            if currentUserEmail.caseInsensitiveCompare(email) == ComparisonResult.orderedSame &&
                currentUserPassword.caseInsensitiveCompare(password) == ComparisonResult.orderedSame{
                
                UserDefaults.standard.set(true, forKey: "isLogged")
                completion (.success)
                return
            }
        }
            // Invalid access
            completion(.fail(dueTo:.invalidCredentials))
    }
}
