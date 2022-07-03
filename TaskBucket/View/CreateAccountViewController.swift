

import UIKit

class CreateAccountViewController: UIViewController {

    let controller = ViewController()
    //Text fields
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var groupNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    //Label
    @IBOutlet weak var errorMessageUIL: UILabel!
    //Variables
    var errorMessage: String?
    //Bar button
    @IBOutlet weak var saveBT: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageUIL.isHidden = true
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        errorMessageUIL.isHidden = true
        
            if validated() {
                let name = controller.cleanData(nameTF.text!)!
                let password = controller.cleanData(passwordTF.text!)!
                let groupName = controller.cleanData(groupNameTF.text!)!
                let email = controller.cleanData(emailTF.text!)!
                
                let user = User (name, password, email, groupName)
                let error = controller.resiterNewUser(email, password , user)
                if error != nil {
                    controller.printError( error! as String , errorMessageUIL)
                } else {
                    navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    
        func validated() -> Bool {
            var chackIfVelid = true
            
            errorMessage = controller.validateFields("name", nameTF.text! as String)
            if errorMessage != nil {
                controller.printError(errorMessage!, errorMessageUIL)
                chackIfVelid = false
            } else {
                errorMessage = controller.validateFields("email", emailTF.text! as String)
                if errorMessage != nil{
                    controller.printError(errorMessage!, errorMessageUIL)
                    chackIfVelid = false
                }else {
                    errorMessage = controller.validateFields("group", groupNameTF.text! as String)
                    if errorMessage != nil {
                        controller.printError(errorMessage!, errorMessageUIL)
                        chackIfVelid = false
                    }else {
                        errorMessage = controller.validateFields("password", passwordTF.text! as String)
                        if errorMessage != nil{
                            controller.printError(errorMessage!, errorMessageUIL)
                            chackIfVelid = false
                        }
                    }
                }
            }
            
            
            return chackIfVelid
        }
}

