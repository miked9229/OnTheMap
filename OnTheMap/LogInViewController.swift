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
        if checkIfEmailOrPasswordIsBlank(string1: emailTextField.text!, string2: passwordTextField.text!) {
            return
        } else {
            loginToUdacity() {(success) in
                if success {
                    print(success)
                    
                } else {
                    performUIUpdatesOnMain {
                        self.InvalidLogIn()
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
    
    
    public func loginToUdacity(_ completionHandlerForLogIn: @escaping (_ success: Bool) -> Void) {
        
    
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(emailTextField.text!)\", \"password\": \"\(passwordTextField.text!)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard (error == nil) else { // Handle error…
                print(error ?? "")
                completionHandlerForLogIn(false)
                return
            }
            
            guard let data = data else {
                completionHandlerForLogIn(false)
                print("Your request returned no data")
                return
                
            }
            
            let range = Range(uncheckedBounds: (5, data.count))
            let newData = data.subdata(in: range) /* subset response data! */
            
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            if let session = parsedResult[UdacityResponseKeys.session] {
                completionHandlerForLogIn(true)
            } else {
                completionHandlerForLogIn(false)
            }
    
  
        
        }
        task.resume()
      
        
    }
    
    public func InvalidLogIn() {
        let alert = UIAlertController(title: "", message: "Invalid Email or Password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
  


}
