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

class MapViewController: UIViewController, MKMapViewDelegate, UINavigationControllerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var studentLocations = [StudentLocation]()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.removeAnnotations(mapView.annotations)
        mapView.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(someMethod), name: NSNotification.Name(rawValue: "SuccessNotification"), object: nil)
        
        studentLocations = appDelegate.studentLocations
        
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
                
        performUIUpdatesOnMain {
            self.mapView.addAnnotations(annotations)
            
        }
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle {
                if let url = toOpen {
                    if url != "" && url.contains(".com") {
                        app.open(URL(string: url)!, options: [:], completionHandler: nil)
                        
                    } else {
                        app.open(URL(string: "http://facebook.com")!, options: [:], completionHandler: nil)
                    }
                    
                    
                } else {
                     app.open(URL(string: "http://facebook.com")!, options: [:], completionHandler: nil)
                    
                }
                
            } else {
                 app.open(URL(string: "http://facebook.com")!, options: [:], completionHandler: nil)
               
            }
        }
    }
    public func someMethod() {
    
    ParseClient.sharedInstance().getUserData() {(data, error) in
            if error == nil {
                if let data = data {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.studentLocations = []
                    appDelegate.studentLocations = data
                }
            }
        performUIUpdatesOnMain {
            self.mapView.reloadInputViews()
        }
        
        }
        NotificationCenter.default.removeObserver(self)

    }
}
    
    

    
    
    

