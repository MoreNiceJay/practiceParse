//
//  DetailViewController.swift
//  practiceParse
//
//  Created by Lee Janghyup on 11/3/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    var object : PFObject?
    
    @IBOutlet weak var texField: UITextField!

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(object?.objectId)

        titleLabel.text = object?.valueForKey("text") as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func deleteButtonTapped(sender: AnyObject) {
        
        let query = PFQuery(className: "Practice")
        query.getObjectInBackgroundWithId((object?.objectId)!) { (obj, error) -> Void in
            if error != nil{
                print(error)
                
            }else{
                obj?.deleteInBackgroundWithBlock({ (success, error) -> Void in
                    if error == nil{
                        
                        print("지워졌음")
                        
                    }
                })
            }
        }
        
    }
    
    @IBAction func editButtonTapped(sender: AnyObject) {
    
    var query = PFQuery(className:"Practice")
    query.getObjectInBackgroundWithId((object?.objectId)!) {
    (obj: PFObject?, error: NSError?) -> Void in
    if error != nil {
    print(error)
    } else if let obj = obj {
    obj["text"] = self.texField.text
    
    obj.saveInBackgroundWithBlock({ (success, error) -> Void in
        if error == nil{
            let myAlert = UIAlertController(title: "성공", message: "업데아트 완료", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: {Void in
            
            self.performSegueWithIdentifier("detailToMain", sender: self)})

            
        }
    })
    }
    }
    }
    

}
