//
//  RegisterNewUserController.swift
//  ConnectWithDB
//
//  Created by Taskeen Ashraf on 26/01/2023.
//

import Foundation
import UIKit
import FirebaseAuth

class RegisterNewUserController : UIViewController {
    
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var confirmPassword : UITextField!
    @IBOutlet weak var errorLabel : UILabel!

    
    override func viewDidLoad() {
        errorLabel.isHidden = true
        
    }
    
    @IBAction func onRegisterTapped()
    {
        if (password.text == confirmPassword.text)
        {
        Auth.auth().createUser(withEmail: email.text ?? "", password: password.text ?? "") { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            print(authResult)
            if error == nil {
                strongSelf.errorLabel.isHidden = true
                let alert = UIAlertController(title: "Success", message: "user Created Successfully", preferredStyle: UIAlertController.Style.alert )
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: self?.dismissVC))
                self?.present(alert,animated: true,completion: nil)


            }
            else
            {
                strongSelf.errorLabel.isHidden = false
                if let error = error as NSError? {
                    if let authError = AuthErrorCode.Code(rawValue: error.code){
                        switch authError {
                        case .invalidEmail:
                            strongSelf.errorLabel.text = "Enter a valid email address"
                        case .emailAlreadyInUse:
                            strongSelf.errorLabel.text = "This email address is already in use."
                        case .missingEmail:
                            strongSelf.errorLabel.text = "Please provide an email address"
                        case .networkError:
                            strongSelf.errorLabel.text = "Couldn't connect to the database. Network Error occured."
                        case .tooManyRequests:
                            strongSelf.errorLabel.text = "Too many requests for Login."
                        case .internalError:
                            strongSelf.errorLabel.text = "An internal error occured."
                        default:
                            strongSelf.errorLabel.text = "An unknown error occured"

                        }
                    }
                }
            }
            
        }
        }else
        {
            let alert = UIAlertController(title: "Password Mismatch", message: "Make sure password and confirm password mismatch", preferredStyle: UIAlertController.Style.alert )
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    func dismissVC(action:UIAlertAction)
    {
        self.dismiss(animated: true)
    }
    
}
