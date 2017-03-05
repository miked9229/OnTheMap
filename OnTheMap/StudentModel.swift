//
//  StudentModel.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/5/17.
//
//

import Foundation


class StudentModel: NSObject {
    
    override init() {
        super.init()
    }
    
    var studentLocations = [StudentLocation]()
    
    
    
    class func sharedInstance() -> StudentModel {
        struct Singleton {
            static var sharedInstance = StudentModel()
        }
        return Singleton.sharedInstance
    
    
    }
    
}
