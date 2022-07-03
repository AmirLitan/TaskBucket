

import UIKit

class TaskViewController: UIViewController {

    var update: (() -> Void)?
    var removeLast: (() -> Void)?
    var defaults = UserDefaults.standard
    let controller = ViewController()
    
    @IBOutlet weak var nameBarT: UINavigationItem!
    @IBOutlet weak var detailsTV: UITextView!
    @IBOutlet weak var URLTF: UITextField!
    @IBOutlet weak var priorityTF: UITextField!
    
    var details: String?
    var priority: Int = 0
    var url: String?
    var id: Int = 0
    var group: String?
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        details = defaults.value(forKey: "details") as? String
        priority = (defaults.value( forKey: "priority") as? Int)!
        url = defaults.value( forKey: "url") as? String
        id = (defaults.value(forKey: "id") as? Int)!
        group = defaults.value(forKey: "group") as? String
        
        detailsTV.text = details!
        URLTF.text = url!
        priorityTF.text = String(priority)
        
        count = (self.defaults.value(forKey: "count") as? Int)!
        
        
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        controller.removeTask(group!, String(id)) {
            print("Task: ", self.id , "was removed")
            
            
            let newCount = self.count - 1
            self.defaults.setValue(newCount, forKey: "count")
            
            if newCount == 0 {
                self.removeLast?()
            } else {
                self.update?()
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func saveChangsBT(_ sender: Any) {
       
        let tmpDetails = detailsTV.text
        let tmpUrl = URLTF.text
        let tmpPriority = priorityTF.text
        
        let task = Task(id,nameBarT.title!,tmpDetails!,Int(tmpPriority!)!,tmpUrl!)
        self.controller.firebaseController.updataTask(task, self.group!, self.id)
        
        self.update?()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
