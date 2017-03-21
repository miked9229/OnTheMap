//
//  TabViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/5/17.
//
//

import Foundation
import UIKit
import SafariServices

class TabViewController: UITabBarController {
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden = false
          self.view.reloadInputViews()
    }
    
    
    
    
    @IBAction func LogOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    
    }
    
    @IBAction func reloadData(_ sender: Any) {
 
        self.view.alpha = 0.25
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.blue
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        ParseClient.sharedInstance().getUserData() {(data, error) in

            
            if error == nil {
                if let data = data {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.studentLocations = []
                    appDelegate.studentLocations = data
                  
                    
                    performUIUpdatesOnMain {
                        self.activityIndicator.stopAnimating()
                        self.view.alpha = 1.0
                        self.view.reloadInputViews()
                    }
                    
                    
                    
                }
                
            } else {
                
                performUIUpdatesOnMain {
                    self.dataLoadError(error: error!)
                    self.activityIndicator.stopAnimating()
                    self.view.alpha = 1.0
                    self.view.reloadInputViews()
                }

                
            }
   
          
        }
            
    
    }
  
    @IBAction func addStudent(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "InformationPostingViewController")
        navigationController?.pushViewController(controller, animated: true)

    
    }
    
    
    public func dataLoadError(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
 
        
         self.present(alert, animated: true, completion: nil)
        

        
    }


}

