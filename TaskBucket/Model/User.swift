//
//  User.swift
//  TaskBucket
//
//  Created by amir litan on 03/06/2022.
//

import Foundation

struct UsersHolder {
    var users: [Int: User]?
    
    init (users: [Int: User]?){
        self.users = users
    }
}

struct User {
    var id: String?
    var name: String?
    var password: String?
    var email: String?
    var group: String?
    
    init (_ name: String,_ password:String,_ email:String, _ group: String){
        //self.id = id
        self.name = name
        self.password = password
        self.email = email
        self.group = group
    }
}
