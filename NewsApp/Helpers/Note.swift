//
//  Note.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 17/01/1444 AH.
//



//  MARK: File for storing code statements:

/*
 
// MARK: REGISTER
 //    private func register(){
 //
 //        // 1.Check email existence
 //        if let currentUserEmail = UserDefaults.standard.string(forKey:"email"){
 //
 //            if currentUserEmail.caseInsensitiveCompare(emailField.text ?? "" ) == ComparisonResult.orderedSame {
 //
 //                view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "The email is already used", options: "OK") { (option) in
 //                    self.resetElements()
 //                    return
 //                }
 //            } else {
 //                // 2.Check passswords match
 //                if passwordField.text != repeatPasswordField.text {
 //                    view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "Password and repeated password do not match", options: "OK") { (option) in
 //                        self.resetElements()
 //                        return
 //                    }
 //                } else {
 //                    UserDefaults.standard.set(emailField.text, forKey: "email")
 //                    UserDefaults.standard.set(passwordField.text, forKey: "password")
 //                    UserDefaults.standard.set(true, forKey: "isLogged")
 //
 //                    navigationController?.pushVC(storyboard: "Main", VCIdetifier: "NewsViewController", animated: true)
 //                }
 //            }
 //        }
 //    }
 
 
// MARK: LOG IN
private func logIn() {
    if let currentUserEmail = UserDefaults.standard.string(forKey:"email"),  let currentUserPassword = UserDefaults.standard.string(forKey:"password"){
        if currentUserEmail.caseInsensitiveCompare(emailField.text ?? "X" ) == ComparisonResult.orderedSame
            &&
            currentUserPassword.caseInsensitiveCompare(passwordField.text ?? "X" ) == ComparisonResult.orderedSame{
            UserDefaults.standard.set(true, forKey: "isLogged")
            navigationController?.pushVC(storyboard: "Main", VCIdetifier: "NewsViewController", animated: true)
        } else {
            view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "You have entered an invalid username or password", options: "OK") { (option) in
                // do something after completion
                self.resetElements()
            }
        }
    }
}
 
 - file to store constants
 - file to initiate theme struct with get proprities
 
 
*/
