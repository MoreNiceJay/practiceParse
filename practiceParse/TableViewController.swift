//
//  TableViewController.swift
//  practiceParse
//
//  Created by Lee Janghyup on 11/3/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {

    var postsArray = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        fetchData()
        
        print(postsArray)

     

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("practiceCell", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel!.text = postsArray[indexPath.row].objectForKey("text") as? String
        return cell
        
        

    }
    
    func fetchData() {
        
        
            
            //empty postArray
            postsArray = []
            
            //bring data from parse
            let query = PFQuery(className: "Practice")
            
            query.orderByDescending("createdAt")
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
                if error == nil && objects != nil{
                    for object in objects! {
                        
                        self.postsArray.append(object)
                        print(self.postsArray)
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mainToDetail" {
        let destViewController : DetailViewController = segue.destinationViewController as! DetailViewController
        let selectedRowIndex = self.tableView.indexPathForSelectedRow
            
            destViewController.object = postsArray[selectedRowIndex!.row] as PFObject
            
            
        }
    }
}
