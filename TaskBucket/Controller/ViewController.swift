//
//  LogInController.swift
//  TaskBucket
//
//  Created by amir litan on 06/06/2022.
//

import Foundation
import UIKit

class ViewController{
    
    //FireBase controller
    let firebaseController = FirebaseController()
    
    func resiterNewUser(_ email: String, _ password: String , _ user: User) -> String? {
        return firebaseController.registerNewUser(email, password, user)
    }
    
    func signInUser( _ email:String , _ password: String, onSuccess: @escaping (_ uid: String?) -> Void, onError: @escaping (_ error: Error?) -> Void ){
        firebaseController.signInEmailPassword(email, password) { uid in
            onSuccess(uid)
        } onError: { error in
            onError(error)
        }
    }
    
    func getUserByUid(_ uid: String?,onSuccess: @escaping (_ user: User) -> Void,
                      onError: @escaping (_ error: Error?) -> Void){
        firebaseController.getUserByUid(uid) { user in
            onSuccess(user)
        } onError: { error in
            onError(error)
        }

    }
    
    func saveDefultTask(_ task:Task ,_ group: String?,_ numId: Int) {
        firebaseController.saveDefultTask(task, group, numId)
    }
    
    func updataTask(_ task:Task ,_ group: String?,_ numId: Int) {
        firebaseController.updataTask(task, group, numId)
    }
    
    func readAllGroupTask(_ group: String?,
                          onSuccess: @escaping (_ tasks: [Task]) -> Void,
                          onError: @escaping (_ error: Error?) -> Void){
        firebaseController.readAllGroupTask(group) { tasks in
            onSuccess(tasks)
        } onError: { error in
            onError(error)
        }

    }
    
    func removeTask(_ group: String?, _ key: String?,onSuccess: @escaping () -> Void){
        firebaseController.removeTask(group, key) {
            onSuccess()
        }
    }
    
    func userLogIn(_ uid: String){
        //logInViewController.navigateToMainTaskScreen(uid)
    }
    
    //Hellpers
    func printError(_ error: String,_ label: UILabel){
        print(error)
        label.text = error
        label.isHidden = false
    }
    
    func cleanData(_ str: String) -> String?{
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    func validateFields( _ field: String, _ str: String) -> String? {
        let cleanStr = cleanData(str)
        if cleanStr == "" {
            return "Please fill in \(field) field!"
        }
        
        if field == "email" {
            if !Utilities.isEmailValid(cleanStr!) {
                return "Email is not valid!"
            }
        }
        if field == "password" {
            if !Utilities.isPasswordValid(cleanStr!){
                return "Please make sure your password is Minimum 8 characters at least 1 Alphabet and 1 Number"
            }
        }
        return nil
    }
}
