//
//  Alert.swift
//  Latest Game
//
//  Created by iPHTech 29 on 30/03/23.
//

import Foundation

import UIKit

class Alert {
    
    static let shared = Alert()
    
    private init() {}
    
    func showAlert(vc: UIViewController, title: String, isNeedToShowCancel: Bool = true, message: String, yesActionTitle: String = "Yes", noActionTitle: String = "Cancel", callback:@escaping((String) -> ())) {
        
        let uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        uiAlert.addAction(UIAlertAction(title: yesActionTitle, style: .default, handler: { action in
            callback(yesActionTitle)
        }))
        
        if isNeedToShowCancel {
            uiAlert.addAction(UIAlertAction(title: noActionTitle, style: .cancel, handler: { action in
                callback(noActionTitle)
            }))
        }
        vc.present(uiAlert, animated: true, completion: nil)
    }
}
