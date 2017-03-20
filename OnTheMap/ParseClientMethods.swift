//
//  ParseClientMethods.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/3/17.
//
//

import Foundation

class ParseClient: NSObject {
    
    
    
    var session = URLSession.shared
    
    // configuration object
    
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    
    
    public func getUserData(_ completionHandlerForGetUserData: @escaping (_ results: [StudentLocation]?, _ error: String?) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?order=-updatedAt&&limit=100")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
         
            
            if error != nil { // Handle error...
                completionHandlerForGetUserData(nil, "Your netowrk request returned an error (no network)")
                return
            }
            
            
            var parsedResult: [String: AnyObject]? = [:]
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
            } catch {
                print("Could not parse JSON data")
            }
            
            let studentLocations = parsedResult?["results"] as? [[String: AnyObject]]
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            let students = StudentLocation.studentLocationsFromResults(studentLocations!)
            completionHandlerForGetUserData(students, nil)
  
        }
        task.resume()
        
    }
    
    

    
    public func postUserData(_ completionHandlerForPostUserData: @escaping (_ success: Bool) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"3407878940\", \"firstName\": \"Bill\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
        
        
        
        
        
    }
    


    
    
    
    
    
    
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
}
