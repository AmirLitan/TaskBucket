

import UIKit
import FirebaseAuth

class RestorPasswordViewController: UIViewController {
    
    
    let controller = ViewController()
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorMessageL: UILabel!
    var errorMessage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorMessageL.isHidden = true
        
        
    }
    
    @IBAction func didTapRestor(_ sender: Any) {
        let auth = Auth.auth()
        
        errorMessage = controller.validateFields("email", emailTF.text! as String)
        if errorMessage != nil {
            controller.printError(errorMessage!, errorMessageL)
            return
        }
        
        auth.sendPasswordReset(withEmail: emailTF.text!) { (error) in
            if let error = error {
                let alert = Utilities.alertController("Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let alert = Utilities.alertController("Password restor", message: "A password reset has been sent to your mail!")
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
