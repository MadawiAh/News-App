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
    
    let theme: AppTheme = NewsAppTheme()
    private let authController = AuthController()
    
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailField.text {
            if let errorMsg = Validator.validateEmail(email){
                emailErrorLable.text = errorMsg
                emailErrorLable.isHidden = false
                return
            }
            emailErrorLable.isHidden = true
            
        }
        checkForValidForm()
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordField.text {
            if let errorMsg = Validator.validatePassword(password){
                passwordErrorLable.text = errorMsg
                passwordErrorLable.isHidden = false
                return
            }
            passwordErrorLable.isHidden = true
        }
        checkForValidForm()
    }
    
    @IBAction func repeatPasswordChanged(_ sender: Any) {
        if let rePassword = repeatPasswordField.text {
            if let errorMsg = Validator.validatePassword(rePassword){
                repeatPasswordErrorLable.text = errorMsg
                repeatPasswordErrorLable.isHidden = false
                return
            }
            repeatPasswordErrorLable.isHidden = true
        }
        checkForValidForm()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        authController.register(email: emailField.text ?? "", password: passwordField.text ?? "", rePassword: repeatPasswordField.text ?? "")
        { (result) in
            
            switch result{
                
            case .fail(dueTo: .emailExists):
                self.view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "The email is already used", options: "OK") { (option) in
                    self.resetElements()
                    return }
                
            case .fail(dueTo: .passwordMismatch):
                self.view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "Password and repeated password do not match", options: "OK") { (option) in self.resetElements()
                    return }
                
            case .success:
                self.navigationController?.pushViewController(TabBarController(), animated: false)
                
            default:
                print("In default")
            }
        }
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        guard let navigationVC = self.navigationController else { return }
        navigationVC.popViewController(animated: false)
        navigationVC.pushVC(storyboard: "Main", VCIdetifier: "LogInViewController", animated: false)
    }
    
    private func checkForValidForm(){
        if emailErrorLable.isHidden && passwordErrorLable.isHidden && repeatPasswordErrorLable.isHidden  {
            if emailField.text?.isEmpty ?? true || passwordField.text?.isEmpty ?? true || repeatPasswordField.text?.isEmpty ?? true{
                
                signUpBtn.isEnabled = false
                return
            }
            signUpBtn.isEnabled = true
        }
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
