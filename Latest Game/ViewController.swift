//
//  ViewController.swift
//  Latest Game
//
//  Created by iPHTech 29 on 30/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNametxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    
    //MARK: Variables
    var isComingFromSignup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: Signup Tap Action
    @IBAction func signUpAction(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
      self.navigationController?.pushViewController(vc!, animated: true)

    }

    //MARK: Login Tap Action
    @IBAction func loginAction(_ sender: Any) {
        
        let userName = userNametxt.text ?? ""
        let password = passwordtxt.text ?? ""
        
        if checkValidation(userName: userName, password: password) {
            let loginUserResult = UserManager.shared.checkUserAbleToLogin(userName: userName, password: password)
            if loginUserResult.errorCode == 200 {
                userStandard.set(loginUserResult.userDetails?.userId, forKey: UserDefaultKey.userId.rawValue)
                userStandard.set(loginUserResult.userDetails?.userName, forKey: UserDefaultKey.userName.rawValue)
                
                userStandard.set("1", forKey: UserDefaultKey.isAlreadyLogin.rawValue)
            }
            else {
                showAlert(message: loginUserResult.errorMessage)
            }
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartGameViewController") as? StartGameViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    //MARK: Check validation
    private func checkValidation(userName: String, password: String) -> Bool {
        
        if userName == "" {
            showAlert(message: "Please enter email")
        }
       
        else if password == "" {
            showAlert(message: "Please enter password")
        }
        else {
            return true
        }
        return false
    }

    private func showAlert(message: String) {

        Alert.shared.showAlert(vc: self, title: "Alert", isNeedToShowCancel: false, message: message, yesActionTitle: "Okay") { _ in }
        
        let userValue = User()
    }
    
}

