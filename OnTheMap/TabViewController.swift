//
//  TabViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/5/17.
//
//

import Foundation
import UIKit

class TabViewController: UITabBarController {
    
  /*
    override func viewWillAppear(_ animated: Bool) {
    
        
        ParseClient.sharedInstance().getUserData() {(data) in
            
            if let data = data {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.studentLocations = []
                appDelegate.studentLocations = data
                
                
           
                
                }
            
            }
        
        } */
    
    
    
    
    
    @IBAction func LogOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    
    }
    
    @IBAction func reloadData(_ sender: Any) {
    }
  
    
    @IBOutlet weak var addStuddent: UIBarButtonItem!
}
