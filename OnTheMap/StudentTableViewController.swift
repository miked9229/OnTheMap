//
//  StudentTableViewController.swift
//  OnTheMap
//
//  Created by Michael Doroff on 3/2/17.
//
//

import Foundation
import UIKit


class StudentTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var studentLocations = [StudentLocation]()
    
    override func viewDidLoad() {
       
        self.tableView.bounces = true
        self.tableView.delegate = self
        
        
        ParseClient.sharedInstance().getUserData() {(data) in
            
            if let data = data {
                self.studentLocations = data
                performUIUpdatesOnMain {
                    self.tableView.reloadData()
                    
                }
                
            }
        
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
        
       // print(cell?.textLabel!.text)

        

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    
        
        
}

