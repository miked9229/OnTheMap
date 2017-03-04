//
//  UdacityStudentLocation.swift
//  OnTheMap
//
//  Created by Michael Doroff on 2/26/17.
//
//

import Foundation

struct StudentLocation {
    
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date?
    let updatedAt: Date?
    
    
    init(dictionary: [String:AnyObject]) {
        objectId = dictionary["objectID"] as? String
        uniqueKey = dictionary["uniqueKey"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        mapString = dictionary["mapString"] as? String
        mediaURL = dictionary["mediaURL"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        createdAt = dictionary["createdAt"] as? Date
        updatedAt = dictionary["updatedAt"] as? Date
        
        
    }
    
    static func studentLocationsFromResults(_ results: [[String:AnyObject]]) -> [StudentLocation] {
        
        var studentLocations = [StudentLocation]()
        
        for result in results {
            
            studentLocations.append(StudentLocation(dictionary: result))
        }
        
        return studentLocations
    }
}
