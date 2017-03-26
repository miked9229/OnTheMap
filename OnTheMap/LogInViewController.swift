//
//  LogInViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 2/25/17.
//
//

import UIKit
import Foundation

class LogInViewController: UIViewController, UITextFieldDelegate {

    var appDelegate: AppDelegate!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
 
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        activityIndicator.isHidden = true
        subscribeToKeyboardNotifications()
        emailTextField.text! = ""
        passwordTextField.text! = ""
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
//: Login Function that checks for correct user id/ password and grabs data
    
@IBAction func loginPressed(_ sender: Any) {
        passwordTextField.resignFirstResponder()
        activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        if checkIfEmailOrPasswordIsBlank(string1: emailTextField.text!, string2: passwordTextField.text!) {
            
            
        } else {
            UdacityClient.sharedInstance().loginToUdacity(emailTextField: emailTextField.text!, passwordTextField: passwordTextField.text!) { (success, account, error) in
                
                if success {
                    
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.userKey = account
                    
                    UdacityClient.sharedInstance().getUserInformation(userKey: account) {(success, firstName, lastName) in
                        
                    appDelegate.firstName = firstName
                    appDelegate.lastName = lastName
                        
            
                    
                    
                    ParseClient.sharedInstance().getUserData() {(data, error) in
                        
                        if let data = data {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.studentLocations = []
                            appDelegate.studentLocations = data
                            performUIUpdatesOnMain {
                                self.dismiss(animated: true, completion: nil)
                                self.presentNavigationController()
                            }
                            
                            
                            
                            
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

    
    func keyboardWillHide(_ notification: Notification) {
        
        if passwordTextField.isFirstResponder || (emailTextField.isFirstResponder && passwordTextField.text! != "") {
            view.frame.origin.y = 0
        }
        
        
        
    }
    
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        /* This function returns the height of the keyboard and it is called in the
         above methods keyboardWillShow() and keyboardWillHide() */
        
        let userinfo = notification.userInfo
        let keyboardSize = userinfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    func subscribeToKeyboardNotifications()  {
        
       // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}
