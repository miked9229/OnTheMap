//
//  UdacityClientMethods.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/2/17.
//
//

import Foundation


class UdacityClient: NSObject {
    
    
    var session = URLSession.shared
    
    // configuration object

    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    
   
    }
    
    
    
    
    
    public func loginToUdacity(emailTextField: String, passwordTextField: String,_ completionHandlerForLogIn: @escaping (_ success: Bool,_ userKey: String,  _ error: String) -> Void) {

        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(emailTextField)\", \"password\": \"\(passwordTextField)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
          
            guard (error == nil) else { // Handle error…
                print(error ?? "")
                completionHandlerForLogIn(false, "", "Your netowrk request returned an error (no network)")
                return
            }
            
      


            guard let data = data else {
                completionHandlerForLogIn(false, "", "Your network request returned an error (no data)")
                return
                
            }
            
            
            
            let range = Range(uncheckedBounds: (5, data.count))
            let newData = data.subdata(in: range) /* subset response data! */
            
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
            } catch {
                return
            }
            
            guard let account = parsedResult["account"] else {
                completionHandlerForLogIn(false, "No Account", "Invalid Log in (No Account Information)")
                return
            }
            
           
            guard let key = account["key"]  as? String else {
                completionHandlerForLogIn(false, "No Key for Account Found", "Invalid Log in (No Key Information)")
                return
            
            }
            
       
           if let _ = parsedResult[UdacityResponseKeys.session] {
                    completionHandlerForLogIn(true, key, "")
                } else {
                    completionHandlerForLogIn(false, "", "Invalid Log In (No Session Key Information)")
                
                
            }
     
            
            
        }
        task.resume()
        
        
    }
    
    
    public func logOut() {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(uncheckedBounds: (5, data!.count))
            let _ = data?.subdata(in: range) /* subset response data! */
            
        }
        task.resume()
        
    }
    

    
    
    public func getUserInformation(userKey: String?, _ completionHandlerForGetUserInformation: @escaping (_ success: Bool,_ firstName: String,  _ LastName: String) -> Void) {
        
        var urlString: String = ""
        
        
        urlString = "https://" + "www.udacity.com/api/users/" + userKey!
     
       
   
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error...
                completionHandlerForGetUserInformation(false, "", "")
            }
            let range = Range(uncheckedBounds: (5, data!.count))
            let newData = data?.subdata(in: range) /* subset response data! */
            
            
            
            
            var parsedResult: [String: Any] = [:]
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String: Any]
            } catch {
                print("Could not parse JSON data")
            }
            
          
            
            guard let userData = parsedResult["user"] as? [String: AnyObject] else {
                print("Could not find user data")
                return
            }
            
            guard let firstName = userData["first_name"] as? String else {
                print("Could not find first name")
                return
            }
            guard let lastName = userData["last_name"] as? String else {
                print("Could not find last name")
                return
            }
     
            
            completionHandlerForGetUserInformation(true, firstName, lastName)
            
            
        }
        task.resume()
        
        
    
        
        
        
    }
    
    
    
    
    
    public func postUserData(mapString: String?, mediaURL: String, lattitude: Double, longitude: Double, uniqueKey: String, firstName: String, lastName: String, completionHandlerForPostUserData: @escaping (_ success: Bool) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
       
        
        request.httpBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString!)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(lattitude), \"longitude\": \(longitude)}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                completionHandlerForPostUserData(false)
            }
        
            
            var parsedResult: [String: Any] = [:]
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            } catch {
                print("Could not parse JSON data")
            }

            
            guard let _ = parsedResult["createdAt"] as? String else {
                completionHandlerForPostUserData(false)
                return
            }
            
            completionHandlerForPostUserData(true)
        
            

        }
        task.resume()
        
        
        
        
        
    }


    
    
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
