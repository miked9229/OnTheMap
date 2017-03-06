//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 2/28/17.
//
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var studentLocations = [StudentLocation]()
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        
     print("MapView Appeared")
      studentLocations = appDelegate.studentLocations
        
       print(studentLocations)
        
        var annotations = [MKPointAnnotation]()
      
        var lat: Double
        var long: Double
        var first: String
        var last: String
        
        
        for dictionary in studentLocations {
            
            lat = 0
            long = 0
            first = ""
            last = ""
            
            if let _ = dictionary.latitude {
                lat = dictionary.latitude!
            
            } else {
                lat = 0
            }
            if let _ = dictionary.longitude {
                long = dictionary.longitude!
                
            } else {
                long = 0
            }
            lat = CLLocationDegrees(lat)
            long = CLLocationDegrees(long)
            

            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
    
            
            if let _ = dictionary.firstName {
                first =  dictionary.firstName!
            } else {
                last = ""
            }
            if let _ = dictionary.lastName {
                last = dictionary.lastName!
            } else {
                last = ""
            }
            
            let mediaURL = dictionary.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
            
            
        
            }
        

        self.mapView.addAnnotations(annotations)
        
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
    
    
    
    
    
    
    
    
            
        
}
    
    

    
    
    

