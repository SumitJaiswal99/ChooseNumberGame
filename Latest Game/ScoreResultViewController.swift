//
//  ScoreResultViewController.swift
//  Latest Game
//
//  Created by iPHTech 29 on 30/03/23.
//

import UIKit

class ScoreResultViewController: UIViewController {
    
    @IBOutlet weak var highScorelbl: UILabel!
    @IBOutlet weak var currentScorelbl: UILabel!
    @IBOutlet weak var userNamelbl: UILabel!
    
    var scorevalue = ""
    var highscore = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        
        userNamelbl.text = userStandard.string(forKey: UserDefaultKey.userName.rawValue)
        currentScorelbl.text =  scorevalue
        highScorelbl.text = highscore
    }
    

    @IBAction func playAgainAction(_ sender: Any) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "StartGameViewController") as! StartGameViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
