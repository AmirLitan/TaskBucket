//
//  Task.swift
//  TaskBucket
//
//  Created by amir litan on 03/06/2022.
//

import Foundation

struct TasksHolder {
    var tasks: [Task]?
    init(_ tasks: [Task]) {
        self.tasks = tasks
    }
}

struct Task {
    var id: Int?
    var name: String?
    var details: String?
    var priority: Int?
    var URL: String?
    
    init (_ id: Int, _ name: String,_ details:String,_ priority:Int, _ URL: String){
        self.id = id
        self.name = name
        self.details = details
        self.priority = priority
        self.URL = URL
    }
}
