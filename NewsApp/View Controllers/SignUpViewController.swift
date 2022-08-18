//
//  SignUpViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 10/01/1444 AH.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var emailErrorLable: UILabel!
    @IBOutlet weak var passwordErrorLable: UILabel!
    @IBOutlet weak var repeatPasswordErrorLable: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInLable: UILabel!
    @IBOutlet weak var logInBtn: UIButton!
    
    private let authenticator = Auth()
    let theme: AppTheme = NewsAppTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
    }
    
    func setUpElements(){
        
        styleElements()
        emptyFields()
        resetElements()
        
    }
    
    fileprivate func styleElements() {
        
        theme.styleViewCard(viewCard)
        
        theme.styleTitleOneLable(titleLable)
        
        theme.styleTextField(emailField)
        theme.styleTextField(passwordField)
        theme.styleTextField(repeatPasswordField)
        
        theme.styleErrorLable(emailErrorLable)
        theme.styleErrorLable(passwordErrorLable)
        theme.styleErrorLable(repeatPasswordErrorLable)
        
        theme.stylePrimaryButton(signUpBtn)
        
        theme.styleTitleFourLable(logInLable)
        theme.styleTitleFourButton(logInBtn)
    }
    
    fileprivate func emptyFields() {
        emailField.text = ""
        passwordField.text = ""
        repeatPasswordField.text = ""
    }
    
    fileprivate func resetElements() {
        signUpBtn.isEnabled = false
        emailErrorLable.isHidden = true
        passwordErrorLable.isHidden = true
        repeatPasswordErrorLable.isHidden = true
    }
    
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popToVC(VCIdetifier: "LandingViewController" , animated: true)
    }
    
    @IBAction func emailChanged(_ sender: Any) {
    OuterIF: if let email = emailField.text {
        if let errorMsg = Validator.validateEmail(email){
            emailErrorLable.text = errorMsg
            emailErrorLable.isHidden = false
            break OuterIF
        }
        emailErrorLable.isHidden = true
        
    }
        checkForValidForm()
    }
    
    
    @IBAction func passwordChanged(_ sender: Any) {
    OuterIF: if let password = passwordField.text {
        if let errorMsg = Validator.validatePassword(password){
            passwordErrorLable.text = errorMsg
            passwordErrorLable.isHidden = false
            break OuterIF
        }
        passwordErrorLable.isHidden = true
    }
        checkForValidForm()
    }
    
    @IBAction func repeatPasswordChanged(_ sender: Any) {
    OuterIF: if let rePassword = repeatPasswordField.text {
        if let errorMsg = Validator.validatePassword(rePassword){
            repeatPasswordErrorLable.text = errorMsg
            repeatPasswordErrorLable.isHidden = false
            break OuterIF
        }
        repeatPasswordErrorLable.isHidden = true
    }
        checkForValidForm()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        authenticator.register(email: emailField.text ?? "", password: passwordField.text ?? "", rePassword: repeatPasswordField.text ?? "")
        { (result) in
            
            switch result{
                
            case .fail(dueTo: .emailExists):
                self.resetElements()
                self.view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "The email is already used", options: "OK") { (_) in }
                
            case .fail(dueTo: .passwordMismatch):
                self.resetElements()
                self.view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "Password and repeated password do not match", options: "OK") { (_) in }
                
            case .success:
                self.navigationController?.pushViewController(TabBarController(), animated: false)
                
            default:
                print("In default")
            }
        }
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        navigationController?.pushVC(storyboard: "Main", VCIdetifier: "LogInViewController", animated: true)
    }
    
    private func checkForValidForm(){
        
        if !emailErrorLable.isHidden ||
            !passwordErrorLable.isHidden ||
            !repeatPasswordErrorLable.isHidden  {
            signUpBtn.isEnabled = false
            return
        }
        
        if emailField.text?.isEmpty ?? true ||
            passwordField.text?.isEmpty ?? true ||
            repeatPasswordField.text?.isEmpty ?? true{
            signUpBtn.isEnabled = false
            return
        }
        signUpBtn.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
            repeatPasswordField.becomeFirstResponder()
        } else if textField == repeatPasswordField {
            repeatPasswordField.resignFirstResponder()
        }
        return true
    }
}
