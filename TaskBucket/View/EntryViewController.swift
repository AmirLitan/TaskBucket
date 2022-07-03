

import UIKit

class EntryViewController: UIViewController , UITextViewDelegate{

    @IBOutlet var fieldTF: UITextField!
    
    var update: (() -> Void)?
    let controller = ViewController()
    let defaults = UserDefaults.standard
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = defaults.value(forKey: "uid")
        controller.getUserByUid(uid as? String) { user in
            self.user = user as User
        } onError: { error in
            print(error!)
        }
        
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        guard let text = fieldTF.text , !text.isEmpty else {
            return
        }
        let count = defaults.value(forKey: "count") as? Int ?? 0 
        let task = Task(count,text,"",3,text)
        let newCount = count + 1
        defaults.setValue(newCount, forKey: "count")
        
        controller.firebaseController.saveDefultTask(task, self.user?.group, newCount)
        
        update?()
        
        navigationController?.popToRootViewController(animated: true)
    }
}
    
