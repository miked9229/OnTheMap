//
//  LogInViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 2/25/17.
//
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func loginPressed(_ sender: Any) {
        print("You pressed the login button!")
    checkIfEmailOrPasswordIsBlank(string1: emailTextField.text!, string2: passwordTextField.text!)
    
    
    
    }


    
    func checkIfEmailOrPasswordIsBlank(string1: String, string2: String) -> Bool {
        if string1 == "" || string2 == "" {
            let alert = UIAlertController(title: "", message: "Empty Email or Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }
        
        
        
        return true
    }
    


}
