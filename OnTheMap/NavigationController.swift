//
//  NavigationController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/5/17.
//
//

import Foundation
import UIKit
import MapKit


class NavigationController: UINavigationController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        performUIUpdatesOnMain {
             self.view.reloadInputViews()
        }
        
    
    }
        
}
    
    
    
