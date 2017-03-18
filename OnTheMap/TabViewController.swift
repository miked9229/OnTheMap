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
    

    
    
    @IBAction func LogOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    
    }
    
    @IBAction func reloadData(_ sender: Any) {
     //   let controller = storyboard!.instantiateViewController(withIdentifier: "InformationPostingViewController")
      //  navigationController?.pushViewController(controller, animated: true)

    
    }
  
    @IBAction func addStudent(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "InformationPostingViewController")
        navigationController?.pushViewController(controller, animated: true)

    
    }


}

