//
//  LoginViewController.swift
//  ConnectWithDB
//
//  Created by Taskeen Ashraf on 25/01/2023.
//

import Foundation
import UIKit
import FirebaseAuth
import CoreData



class LoginViewController : UIViewController {
    
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var errorLabel : UILabel!
    
    
    override func viewDidLoad() {

        errorLabel.isHidden = true
    }
    
    @IBAction func onLoginTapped()
    {
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if (error == nil)
            {
                strongSelf.errorLabel.isHidden = true
                //successful login
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DisplayDataViewController")
                strongSelf.present(vc, animated: true)
            }else
            {
                strongSelf.errorLabel.isHidden = false
                if let error = error as NSError? {
                    if let authError = AuthErrorCode.Code(rawValue: error.code){
                        switch authError {
                        case .invalidEmail:
                            strongSelf.errorLabel.text = "Enter a valid email address"
                        case .userNotFound:
                            strongSelf.errorLabel.text = "User is not found in the database."
                        case .wrongPassword:
                            strongSelf.errorLabel.text = "You entered the wrong password"
                        case .networkError:
                            strongSelf.errorLabel.text = "Couldn't connect to the database. Network Error occured."
                        case .tooManyRequests:
                            strongSelf.errorLabel.text = "Too many requests for Login."
                        case .userDisabled:
                            strongSelf.errorLabel.text = "User is disabled in the database"
                        case .internalError:
                            strongSelf.errorLabel.text = "An internal error occured."
                        default:
                            strongSelf.errorLabel.text = "An unknown error occured"

                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onCreateNewUserTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterNewUserController")
        self.present(vc, animated: true)
    }
}
