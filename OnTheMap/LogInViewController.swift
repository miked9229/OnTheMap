//
//  LogInViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 2/25/17.
//
//

import UIKit
import Foundation

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if checkIfEmailOrPasswordIsBlank(string1: emailTextField.text!, string2: passwordTextField.text!) {
            
            
        } else {
            UdacityClient.sharedInstance().loginToUdacity(emailTextField: emailTextField.text!, passwordTextField: passwordTextField.text!) { (success, error) in
                if success {
                
                    UdacityClient.sharedInstance().logOut()
                    performUIUpdatesOnMain {
                        self.dismiss(animated: true, completion: nil)
                        self.presentNavigationController()
                    }
                    
                } else {
                   
                    
                    performUIUpdatesOnMain {
                        
                        self.InvalidLogIn(error: error)
                    }
                
            }
        }
    
    
        }
    }
    public func checkIfEmailOrPasswordIsBlank(string1: String, string2: String) -> Bool {
        if string1 == "" || string2 == "" {
            let alert = UIAlertController(title: "", message: "Empty Email or Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            
            self.present(alert, animated: true, completion: nil)
            
            return true
            
            
        }
        return false
    }
 
    public func InvalidLogIn(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
 
    public func presentNavigationController() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ManagerNavigationController") as! UINavigationController
        present(controller, animated: true, completion: nil)
        
    }
    

  


}
