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

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
    
        self.getUserData()
            
        
    }
    
    
    
    public func getUserData() {
        
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
    
    }
    
    
    
}
