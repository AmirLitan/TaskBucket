//
//  Utilities.swift
//  TaskBucket
//
//  Created by amir litan on 10/06/2022.
//

import Foundation
import UIKit

class Utilities {
    
    //password Valid (lenght is 8, one alphabet, one sprcial character)
    static func isPasswordValid(_ password: String) -> Bool{
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    //Email Valid
    static func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@",emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func alertController(_ title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        return alert
    }
   
    
}
