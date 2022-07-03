

import UIKit
import FirebaseDatabase
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth


class LogInViewController: UIViewController {
    
    //controller
    let controller = ViewController()
    //text Fields
    @IBOutlet weak var enterEmailTF: UITextField!
    @IBOutlet weak var enterPasswordTF: UITextField!
    //buttons
    @IBOutlet weak var errorMessageUIL: UILabel!
    @IBOutlet weak var signInBT: UIButton!
    @IBOutlet weak var signUpBT: UIButton!
    @IBOutlet weak var ForgotPasswordBT: UIButton!
    
    //Variables
    var errorMessage: String?
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorMessageUIL.isHidden = true
    
        if defaults.bool(forKey: "isSignIn") {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainNavCon") as! UINavigationController
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    @IBAction func didTapSginInBT(_ sender: Any) {
    
        print("Sgin In was taped")
        var chackIfVelid = true
        
        errorMessage = controller.validateFields("email", enterEmailTF.text! as String)
        if errorMessage != nil {
            controller.printError(errorMessage!, errorMessageUIL)
            chackIfVelid = false
        }
        errorMessage = controller.validateFields("password", enterPasswordTF.text! as String)
        if errorMessage != nil {
            controller.printError(errorMessage!, errorMessageUIL)
        }
        if chackIfVelid {
            let email = controller.cleanData(enterEmailTF.text! as String)!
            let password = controller.cleanData(enterPasswordTF.text! as String)!
            
           
            
            controller.signInUser(email, password) { uid in
                self.defaults.setValue(uid!, forKey: "uid")
                self.defaults.setValue(true, forKey: "isSignIn")
                self.enterEmailTF.text = ""
                self.enterPasswordTF.text = ""
                self.navigateToMainTaskScreen()
            } onError: { error in
                print("-----------" , error! , "-------------")
                self.controller.printError("ERROR! User didnt load", self.errorMessageUIL)
            }
        }
    }
    
    @IBAction func didTapForgotPassword(_ sender: Any) {
        //self.performSegue(withIdentifier: "forgot_password", sender: nil)
    }
    
    @IBAction func didTapCreateAccount(_ sender: Any) {
       // self.performSegue(withIdentifier: "signup", sender: nil)
    }
   
    @objc
    func navigateToMainTaskScreen() {
        self.performSegue(withIdentifier: "user_sign_in", sender: nil)
    }
    
}

