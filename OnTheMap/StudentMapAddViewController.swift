//
//  StudentMapAddViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/12/17.
//
//

import Foundation
import UIKit
import MapKit

class StudentMapAddViewController: UIViewController,  MKMapViewDelegate{
    
    var annotation: MKPointAnnotation? = nil
    var locationTextField: String? = ""
    var latitude: CLLocationDegrees? = nil
    var longitude: CLLocationDegrees? = nil
    var clPlaceMark: [[String:AnyObject]]? = [[:]]
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var urlField: UITextField!
    var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(locationTextField!)
         UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
        
        
        
        print(navigationController?.viewControllers)
   
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        
    
      
        self.navigationController?.isNavigationBarHidden = true
        
       
    
        
        guard let annotation = annotation else {
            print("Error")
            return
        }
        
        let span = MKCoordinateSpanMake(0.5, 0.5)
        
        let location = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.addAnnotation(annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
            
        }
        return pinView
    }
    
    
    

    
    @IBAction func Cancel(_ sender: Any) {
   _ = self.navigationController?.popToRootViewController(animated: true)

    
  
    }
    

    @IBAction func Submit(_ sender: Any) {
       
        self.view.alpha = 0.25
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.blue
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        

        

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UdacityClient.sharedInstance().postUserData(mapString: locationTextField!, mediaURL: urlField.text!, lattitude: latitude!, longitude: longitude!, uniqueKey: appDelegate.userKey!, firstName: appDelegate.firstName!, lastName: appDelegate.lastName!) { (success) in
            
            if success {
                performUIUpdatesOnMain {
                self.activityIndicator.stopAnimating()
                self.view.alpha = 1.0
               NotificationCenter.default.post(name: Notification.Name(rawValue:  "SuccessNotification"), object: self)
                    
 
                    
                    _ = self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                performUIUpdatesOnMain {
                    self.raiseError()
                     _ = self.navigationController?.popToRootViewController(animated: true)
                    
                }
            }
   
            
        }
    }
    
    
    
    
    
    public func raiseError() {
        let alert = UIAlertController(title: "", message: "Your message errored", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }


    
}
