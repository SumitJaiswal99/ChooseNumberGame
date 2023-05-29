//
//  LoginViewController.swift
//  Latest Game
//
//  Created by iPHTech 29 on 30/03/23.
//

import UIKit

class StartGameViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var digitsLabel: UILabel!
    @IBOutlet weak var chancesLabel: UILabel!
    @IBOutlet weak var chanceLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var highScorelbl: UILabel!
    @IBOutlet weak var currentScorelbl: UILabel!
    @IBOutlet weak var guessNumbertxt: UITextField!
    
    var highScore = UserDefaults().integer(forKey: "HIGHSCORE")
    
    var userName = ""
    
    
    //MARK: Define variables
    var value = 0
    
    var score = 0 {
        didSet {
            currentScorelbl.text = "Current Score = \(score)"
        }
    }
    
    var maxvalue = 0
    let MAX_LENGTH_Text = 1
    let ACCEPTABLE_NUMBERS = "123456"
    
    var counter = 5 {
        didSet {
            chancesLabel.text = "\(counter)"
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        score = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = userStandard.string(forKey: UserDefaultKey.userName.rawValue)
//        highScorelbl.text = "High Score = \(UserDefaults().integer(forKey: "HIGHSCORE"))"
       
        guessNumbertxt.delegate = self
        let userName = userStandard.string(forKey: UserDefaultKey.userName.rawValue) as? String
        self.userName = userName ?? ""
        let highScore = userStandard.string(forKey: "\(self.userName)_\(UserDefaultKey.highScore.rawValue)") ?? ""
        highScorelbl.text = "High Score = \(highScore)"
    }
    
    @IBAction func exitGameAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScoreResultViewController") as? ScoreResultViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.scorevalue =  currentScorelbl.text ?? ""
        vc?.highscore =   highScorelbl.text ?? ""
    }
    
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == guessNumbertxt {
            let newLength: Int = textField.text!.count + string.count - range.length
            let numberOnly = NSCharacterSet.init(charactersIn: ACCEPTABLE_NUMBERS).inverted
            let strValid = string.rangeOfCharacter(from: numberOnly) == nil
            return (strValid && (newLength <= MAX_LENGTH_Text))
        }
        return true
    }
    
    
    func generateRandomNumber(){
        
        let number = Int.random(in: 1...6)
        digitsLabel.text = "\(number)"
        
        
            let int = (guessNumbertxt.text! as NSString).integerValue
            value = (abs(int - number))
            
            if (value == 0 || value == 1) {
                score += 3
            }
            else if (value == 2 || value == 3) {
                score += 2
            }
            else {
                score += 1
            }
            
            var highScore = userStandard.string(forKey: "\(self.userName)_\(UserDefaultKey.highScore.rawValue)") ?? "0"
            
            if score >= Int(highScore)! {
                highScore = "\(score)"
                userStandard.set(highScore, forKey: "\(self.userName)_\(UserDefaultKey.highScore.rawValue)")
                //saveHighScore()
                highScorelbl.text = "High Score = \(highScore)  "
            }
        
    }
    
    @IBAction func playAction(_ sender: Any) {
        if guessNumbertxt.text != "" {
            if counter > 0 {
                counter -= 1
                generateRandomNumber()
            }
            else {
                chanceLabel.text = " Game Over!"
                //navigate to next page
                let vc = storyboard?.instantiateViewController(withIdentifier: "ScoreResultViewController") as! ScoreResultViewController
                navigationController?.pushViewController(vc, animated: true)
                vc.scorevalue =  currentScorelbl.text ?? ""
                vc.highscore =   highScorelbl.text ?? ""
            }
        }
    else
       {            showAlert(message: "Please enter your guess number") }

    }
    
    private func showAlert(message: String) {

        Alert.shared.showAlert(vc: self, title: "Alert", isNeedToShowCancel: false, message: message, yesActionTitle: "Okay") { _ in }
      
    }
}



