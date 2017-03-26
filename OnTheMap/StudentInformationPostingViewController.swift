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

class StudentInformationPostingViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
        self.navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationTextField.text! = ""
        locationTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextField.resignFirstResponder()
        return true
    }
    
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
        
        self.view.alpha = 0.25
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.blue
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        geocoder.geocodeAddressString(address) {(result, error) in
            
            self.activityIndicator.stopAnimating()
            self.view.alpha = 1.0
            
            
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
        
            let alert = UIAlertController(title: "", message: "There was an address error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            
            self.present(alert, animated: true, completion: nil)
    }

    
}
