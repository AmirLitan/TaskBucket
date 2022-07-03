

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var gmailUIL: UILabel!
    @IBOutlet weak var groupUIL: UILabel!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gmailUIL.text = defaults.value(forKey: "gmail") as? String
        groupUIL.text = defaults.value(forKey: "group") as? String
       
    }
    

    @IBAction func didTapLogOut(_ sender: Any) {
        let auth = Auth.auth()

        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.setValue(false, forKey: "isSignIn")
            self.defaults.setValue(false, forKey: "isSignIn")
           self.dismiss(animated: true, completion: nil)
        } catch let sinOutError {
            print(sinOutError.localizedDescription)
        }
    }
}
