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
    
    
    
    @IBOutlet weak var locationTextField: UITextField!
    
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    
    
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
           
            
            print(coordinate)
      
            annotation.coordinate = coordinate
            
        }
    
        
    }
    func raiseAddressError() {
        print("There was an address error")
    }
    
}
