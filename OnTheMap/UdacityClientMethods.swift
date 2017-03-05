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
    
    
    
    
    
    public func loginToUdacity(emailTextField: String, passwordTextField: String,_ completionHandlerForLogIn: @escaping (_ success: Bool) -> Void) {

        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(emailTextField)\", \"password\": \"\(passwordTextField)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard (error == nil) else { // Handle error…
                print(error ?? "")
                completionHandlerForLogIn(false)
                return
            }
            
            print(data)
            print(response)
            print(error)
            
            guard let data = data else {
                completionHandlerForLogIn(false)
                print("Your request returned no data")
                return
                
            }
            
            let range = Range(uncheckedBounds: (5, data.count))
            let newData = data.subdata(in: range) /* subset response data! */
            
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            print(parsedResult)
            if let _ = parsedResult[UdacityResponseKeys.session] {
                completionHandlerForLogIn(true)
            } else {
                completionHandlerForLogIn(false)
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
    
    
    
    
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
