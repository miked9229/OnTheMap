//
//  StudentTableViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/2/17.
//
//

import Foundation
import UIKit
import SafariServices


class StudentTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var studentLocations = [StudentLocation]()
    


    
    override func viewDidLoad() {
       
   
      studentLocations = appDelegate.studentLocations
        

                performUIUpdatesOnMain {
                    self.tableView.reloadData()
                    
                
                
            }
        
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        studentLocations = appDelegate.studentLocations
        
        performUIUpdatesOnMain {
            self.tableView.reloadData()
            
            
            
        }
        
    }

}





extension StudentTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return studentLocations.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Get cell type */
        let cellReuseIdentifier = "StudentCell"
        //let movie = movies[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        let student = studentLocations[(indexPath as NSIndexPath).row]
        
        /* Set cell defaults */
       
        if let studentFirstName = student.firstName {
            if let studentLastName = student.lastName {
                   cell?.textLabel!.text = studentFirstName + " " + studentLastName
                
            } else {
                cell?.textLabel!.text = studentFirstName
            }
        } else {
             cell?.textLabel!.text = ""
        }
        
        
     
        cell?.imageView?.image = UIImage(named: "Pin")
        
      

        

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         let student = studentLocations[(indexPath as NSIndexPath).row]
        
        if let url = student.mediaURL {
            
            if url.contains("http") {
                let viewcontroller = SFSafariViewController(url: URL(string: url)!)
                present(viewcontroller, animated: true, completion: nil)
                
            } else {
                let viewcontroller = SFSafariViewController(url: URL(string: "http://wwww.facebook.com")!)
                present(viewcontroller, animated: true, completion: nil)

            }
          
            
        }
    }
    
   
    
        
        
}

