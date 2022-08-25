//
//  LogInViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 10/01/1444 AH.
//

import UIKit

/* Valid user :
 email: M@gmail.com
 password: Mm1234
 */

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailErrorLable: UILabel!
    @IBOutlet weak var passwordErrorLable: UILabel!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpLable: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
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
        
        theme.styleErrorLable(emailErrorLable)
        theme.styleErrorLable(passwordErrorLable)
        
        theme.stylePrimaryButton(logInBtn)
        
        theme.styleTitleFourLable(signUpLable)
        theme.styleTitleFourButton(signUpBtn)
    }
    
    fileprivate func emptyFields() {
        emailField.text = ""
        passwordField.text = ""
    }
    
    private func resetElements() {
        logInBtn.isEnabled = false
        emailErrorLable.isHidden = true
        passwordErrorLable.isHidden = true
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
        if  let password = passwordField.text {
            if password.isEmpty {
                passwordErrorLable.text = "Field required"
                passwordErrorLable.isHidden = false
                return
            }
            passwordErrorLable.isHidden = true
        }
        checkForValidForm()
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        
        authController.logIn(email: emailField.text ?? "", password: passwordField.text ?? "")
        { (result) in
            
            switch result {
                
            case .success:
                self.navigationController?.pushViewController(TabBarController(), animated: false)
                
            case .fail(dueTo: .invalidCredentials):
                self.view.window?.rootViewController?.presentAlertWithTitleAndMessage(title: "Alert", message: "You have entered an invalid username or password", options: "OK")
                { (option) in
                    self.resetElements() }
                
            default:
                print("In default")
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        guard let navigationVC = self.navigationController else { return }
        navigationVC.popViewController(animated: false)
        navigationVC.pushVC(storyboard: "Main", VCIdetifier: "SignUpViewController", animated: false)
    }
    
    private func checkForValidForm(){
        if emailErrorLable.isHidden && passwordErrorLable.isHidden {
            if emailField.text?.isEmpty ?? true || passwordField.text?.isEmpty ?? true{
                
                logInBtn.isEnabled = false
                return
            }
            logInBtn.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
        }
        return true
    }
}
