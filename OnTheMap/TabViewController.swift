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

class TabViewController: UITabBarController, UINavigationControllerDelegate {
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
      
        tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        navigationController?.delegate = self
    }
    

    @IBAction func LogOut(_ sender: Any) {
        UdacityClient.sharedInstance().logOut()
        dismiss(animated: true, completion: nil)
       
    }
    
    @IBAction func reloadData(_ sender: Any) {
 
        view.alpha = CGFloat(Constants.GoodAmountOfDim)
        activityIndicator.center = view.center
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.blue
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        NotificationCenter.default.post(name: Notification.Name(rawValue:  "SuccessNotification"), object: self)
        
        ParseClient.sharedInstance().getUserData() {(data, error) in

            if error == nil {
                if let data = data {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.studentLocations = []
                    appDelegate.studentLocations = data
                  
                    performUIUpdatesOnMain {
                        self.activityIndicator.stopAnimating()
                        self.view.alpha = CGFloat(Constants.NormalAmountOfDim)
                        self.view.reloadInputViews()
                    }
            
                }
                
            } else {
                
                performUIUpdatesOnMain {
                    self.dataLoadError(error: error!)
                    self.activityIndicator.stopAnimating()
                    self.view.alpha = CGFloat(Constants.NormalAmountOfDim)
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
 
        
         present(alert, animated: true, completion: nil)
        

        
    }

}

