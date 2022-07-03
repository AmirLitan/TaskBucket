

import UIKit
import FirebaseDatabase

class TaskListViewController: UIViewController   {
    
    @IBOutlet var tableView: UITableView!
    var tasks = [Task]()
    let controller = ViewController()
    let defaults = UserDefaults.standard
    var  user: User?
    var newCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TaskTableViewCell")
        
        let uid = defaults.value(forKey: "uid")
        controller.getUserByUid(uid as? String) { user in
            self.user = user as User
            self.updataTasks()
        } onError: { error in
            print(error!)
        }
       
    }
    
    func removeLastTask() {
        tasks.removeAll()
        tableView.reloadData()
    }
    
    func updataTasks() {
        tasks.removeAll()
        
        controller.readAllGroupTask(user?.group) { tasks in
            
            self.tasks = tasks
            self.tasks.sort { $0.priority! > $1.priority! }
            self.newCount = self.tasks.count
            self.defaults.setValue(self.newCount, forKey: "count")
            print(self.newCount)
            
            
             self.tableView.reloadData()
        } onError: { error in
            print(error!)
        }
        
    }
    
    @IBAction func didTapMyProfile(_ sender: Any) {
        defaults.setValue(self.user?.email, forKey: "gmail")
        defaults.setValue(self.user?.group, forKey: "group")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.title = user?.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        vc.update = {
            self.updataTasks()
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:  indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.title = tasks[indexPath.row].name
        defaults.setValue(tasks[indexPath.row].details, forKey: "details")
        defaults.setValue(tasks[indexPath.row].priority, forKey: "priority")
        defaults.setValue(tasks[indexPath.row].URL, forKey: "url")
        defaults.setValue(tasks[indexPath.row].id, forKey: "id")
        defaults.setValue(user?.group, forKey: "group")
        
        vc.update = {
            self.updataTasks()
        }
        vc.removeLast = {
            self.removeLastTask()
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell" , for: indexPath) as! TaskTableViewCell
        
        cell.taskCellUIL.text = tasks[indexPath.row].name
        
        cell.networkCellBT.tag = indexPath.row
        cell.networkCellBT.addTarget(self, action: #selector(didTapNetworkBT(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func didTapNetworkBT(sender:UIButton){
        let rowIndex = sender.tag
        var replacedString: String?
        
        if let url = URL(string: tasks[rowIndex].URL!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else  {
            
            let urlString = tasks[rowIndex].name!
            if let range = urlString.range(of: " "){
                replacedString = urlString.replacingCharacters(in: range, with: "+")
            }
            print(replacedString!)
                
            let url : String? = ("https://www.bing.com/search?q=" + replacedString!)
            if let defaultUrl = URL(string: url! ) {
                UIApplication.shared.open(defaultUrl, options: [:], completionHandler: nil)
                print("---------Default URL was opened----------")
            } else {
                print("---------- ERROR URL ----------")
               let alert =  Utilities.alertController("URL is not valid", message: "check if url is valid in task details")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
