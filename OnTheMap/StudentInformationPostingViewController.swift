//
//  StudentInformationPostingViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/12/17.
//
//

import Foundation
import UIKit
import MapKit

class StudentInformationPostingViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
     UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
    
    }
    
    
    
    @IBOutlet weak var locationTextField: UITextField!
    
    
    @IBAction func Cancel(_ sender: Any) {
       _ = navigationController?.popToRootViewController(animated: true)
    
    
    }
    
    
    @IBAction func FindOnMap(_ sender: Any) {
        let annotation = MKPointAnnotation()
        
        
        guard let addressFromString = locationTextField.text else {
            raiseAddressError()
            return
        }
        
        let address = addressFromString
        let geocoder = CLGeocoder()
    
        geocoder.geocodeAddressString(address) {(result, error) in
            
            guard let result = result else {
                self.raiseAddressError()
                return
            }
            
            if (error != nil) {
                self.raiseAddressError()
                return
            }
            
         
            
            let latitude = (result[0].location?.coordinate.latitude)
            let longitude = (result[0].location?.coordinate.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
           
       
            let addressArray = result[0].addressDictionary?["FormattedAddressLines"] as? [String]
            
            
           
            
            annotation.coordinate = coordinate
            
            
            
            let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "StudentMapAddViewController") as! StudentMapAddViewController
            
            viewcontroller.annotation = annotation
            viewcontroller.latitude = latitude
            viewcontroller.longitude = longitude
            viewcontroller.locationTextField =
                addressArray?[0]
            
            
    
            

            self.navigationController?.pushViewController(viewcontroller, animated: true)
           
        
            
        
           
            
            
            
            
            
            
        }

    
        
    }
    func raiseAddressError() {
        print("There was an address error")
    }
    
}
