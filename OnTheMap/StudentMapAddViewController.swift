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
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var urlField: UITextField!
    
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
        UdacityClient.sharedInstance().getUserID()
       // ParseClient.sharedInstance().postStudentLocation()
    }
    
    



    
}
