//
//  SignUpViewController.swift
//  Latest Game
//
//  Created by iPHTech 29 on 30/03/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userNameSignUptxt: UITextField!
    @IBOutlet weak var passwordSignUptxt: UITextField!
    @IBOutlet weak var confirmPasswordtxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpUserAction(_ sender: Any) {
        
        let userName = userNameSignUptxt.text ?? ""
        let password = passwordSignUptxt.text ?? ""
        let confirmPassword = confirmPasswordtxt.text ?? ""
        
        if checkValidation(userName: userName, password: password, confirmPassword: confirmPassword) {
            
            let createUserResult = UserManager.shared.createUser(userName: userName, password: password)
            if createUserResult.errorCode == 200 {
                showAlert(message: "\(createUserResult.errorMessage)!")
                
//                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
              
                Alert.shared.showAlert(vc: self, title: "Alert", isNeedToShowCancel: true, message: "\(createUserResult.errorMessage).", yesActionTitle: "Yes", noActionTitle: "No") { [weak self] value in
               
                    guard self != nil else { return }
                    // \nDo you want to login ?
                  
               //     vc.navigationController?.popViewController(animated: true)
                }
                
            }
            else {
                showAlert(message: createUserResult.errorMessage)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Check validation
    private func checkValidation(userName: String,password: String, confirmPassword: String) -> Bool {
        
        if userName == "" {
            showAlert(message: "Please enter User name")
        }
        
        else if password == "" {
            showAlert(message: "Please enter password")
        }
        else if confirmPassword == "" {
            showAlert(message: "Please enter confirm password")
        }
        else if password != confirmPassword {
            showAlert(message: "Password doesn't match")
        }
        else {
            return true
        }
        return false
    }
    
    private func showAlert(message: String) {
        
        Alert.shared.showAlert(vc: self, title: "Alert", isNeedToShowCancel: false, message: message, yesActionTitle: "Done") { _ in }
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
