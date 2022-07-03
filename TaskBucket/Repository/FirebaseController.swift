//
//  FirebaseController.swift
//  TaskBucket
//
//  Created by amir litan on 10/06/2022.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class FirebaseController{
    
    
    private let database = Database.database(url: "https://task-bucket-ios-default-rtdb.europe-west1.firebasedatabase.app").reference()
    private let database2 = Database.database(url: "https://task-bucket-ios-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    typealias UserMap = [String: Any]
    typealias TaskMap = [String: Any]
    
    //Register new user only email password
    func registerNewUser(_ email: String, _ password: String, _ user: User) -> String? {
        var userId: String?
        Auth.auth().createUser(withEmail: email, password: password) { [self] (result , error) in
            if error != nil {
                print(error!)
                userId = "ERRROR! - User was not register!"
            } else {
                print("--------------------- USER WAS CREATED --------------- ")
                let object: UserMap = ["id": result?.user.uid as Any,
                                       "name":user.name!,
                                       "password":user.password!,
                                       "email":user.email!,
                                       "group": user.group!]
                self.database.child("users").child((result?.user.uid)!).setValue(object)
                uplodeNewUser(user, (result?.user.uid)! as String)
                userId = nil
            }
        }
        return userId
    }
    
    //Set new user
    func uplodeNewUser(_ user: User,_ uid : String){
        let object: UserMap = ["id": uid,
                               "name":user.name!,
                               "password":user.password!,
                               "email":user.email!,
                               "group": user.group!]
        self.database.child("users").child(uid).setValue(object)
    }
    
    
    func signInEmailPassword(_ email: String , _ password: String,
                             onSuccess: @escaping (_ uid: String?) -> Void,
                             onError: @escaping (_ error: Error?) -> Void) {
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                onError(error!)
                return
            }
            onSuccess(result!.user.uid)
        }
    }
    
    func getUserByUid(_ uid: String?,onSuccess: @escaping (_ user: User) -> Void,
                      onError: @escaping (_ error: Error?) -> Void) {
        
        self.database.child("users/\(uid!)").getData(completion: { error, snapshot in
            guard error == nil else {
                print("--------" , error! , "---------")
                onError(error)
                return
            }
            let value = snapshot?.value as? NSDictionary
            let name = value?["name"] as? String
            let password = value?["password"] as? String
            let email = value?["email"] as? String
            let group = value?["group"] as? String
            let user = User(name!,password!,email!,group!)
            onSuccess(user)
            });
    }
    
    func saveDefultTask(_ task:Task ,_ group: String?,_ numId: Int) {
        let object: TaskMap = ["id": numId,
                               "name":task.name!,
                               "details":task.details!,
                               "priority":task.priority!,
                               "URL": task.URL!]
        self.database.child("Tasks").child(group!).child(String(numId)).setValue(object)
        print("---------- Defult Task Save ----------")
    }
    
    func readAllGroupTask(_ group: String?,
                          onSuccess: @escaping (_ Tasks: [Task]) -> Void,
                          onError: @escaping (_ error: Error?) -> Void){
        var tasks : [Task] = []
        self.database.child("Tasks").child(group!).observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                
                self.database2.child("Tasks").child(group!).child(key).observeSingleEvent(of: .value) { snapshotChild in
                    let value = snapshotChild.value as? NSDictionary
                    let name = value?["name"] as? String
                    let details = value?["details"] as? String
                    let priority = value?["priority"] as? Int
                    let URL = value?["URL"] as? String
                    let id = Int(key)
                    print("--------- key: " ,key, "------------" )
                    let task = Task(id!,name!,details!,priority!,URL!)
                    tasks.append(task)
                    onSuccess(tasks)
                }
                
            }
        }
    }
    func removeTask(_ group: String?, _ key: String?,onSuccess: @escaping () -> Void) {
        database.child("Tasks").child(group!).child(key!).removeValue { error, FIRDatabaseReference in
            if error != nil {
                print("--------",error! ,"--------")
                return
            }
            onSuccess()
        }
    }
    
    func updataTask(_ task:Task ,_ group: String?,_ numId: Int) {
        let object: TaskMap = ["id": numId,
                               "name":task.name!,
                               "details":task.details!,
                               "priority":task.priority!,
                               "URL": task.URL!]
        self.database.child("Tasks").child(group!).child(String(numId)).updateChildValues(object)
        
        print("----------  Task Updated ----------")
    
    }
    
}
