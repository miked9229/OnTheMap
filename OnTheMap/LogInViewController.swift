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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.isHidden = true

    }
    
    

    
    
    
    @IBAction func loginPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        if checkIfEmailOrPasswordIsBlank(string1: emailTextField.text!, string2: passwordTextField.text!) {
            
            
        } else {
            UdacityClient.sharedInstance().loginToUdacity(emailTextField: emailTextField.text!, passwordTextField: passwordTextField.text!) { (success, error) in
                
      
                
                if success {
                    
                
                    
                    ParseClient.sharedInstance().getUserData() {(data, error) in
                        
                        if let data = data {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.studentLocations = []
                            appDelegate.studentLocations = data
                          //  UdacityClient.sharedInstance().logOut()
                            performUIUpdatesOnMain {
                                self.dismiss(animated: true, completion: nil)
                                self.presentNavigationController()
                            }
                            
                            
                            
                            
                        }
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
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            
            return true
            
            
        }
        return false
    }
 
    public func InvalidLogIn(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
 
    public func presentNavigationController() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ManagerNavigationController") as! UINavigationController
        present(controller, animated: true, completion: nil)
        
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        
    }
    

  


}
