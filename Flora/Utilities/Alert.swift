//
//  Alert.swift
//  Flora
//
//  Created by Mark on 18/11/2018.
//  Copyright © 2018 Mark Villar. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func showAlertWithMultipleActions(on view: UIViewController, title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        view.present(alert, animated: true, completion: nil)
    }
    
    private static func showAlert(on view: UIViewController, title: String, message: String) {
        let action:[UIAlertAction] = [UIAlertAction(title: "Ok", style: .default, handler: nil)]
        showAlertWithMultipleActions(on: view, title: title, message: message, actions: action)
    }
    
}

extension Alert {
    
    public static func locationServicesTurnedOff(on vc: UIViewController) {
        showAlert(on: vc, title: "Location services is turned off", message: "Enable location services in Settings > Privacy > Location Services in order to make the application work properly.")
    }
    
    public static func customAlert(title: String, message: String, on vc: UIViewController) {
        showAlert(on: vc, title: title, message: message)
    }
    
}
