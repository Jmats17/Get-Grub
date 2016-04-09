//
//  SetTimeViewController.swift
//  Get Grub
//
//  Created by Justin Matsnev on 3/28/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SetTimeViewController : UIViewController {
    
    @IBOutlet var datePicker : UIDatePicker!
    @IBOutlet var goButton : UIButton!
    var date : NSDate!
    var ref = Firebase(url:"https://get-grub.firebaseio.com")
    var groupID : String!
    
    @IBAction func go(sender : AnyObject) {
        addDateToGroup()
        
        self.performSegueWithIdentifier("datetomain", sender: nil)
    }
    
    func addDateToGroup() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let dateString = dateFormatter.stringFromDate(datePicker.date)
        let date = [
            "date" : dateString
        ]
        
        let groupRef = ref.childByAppendingPath("groups/\(groupID)")
        groupRef.updateChildValues(date)
        
    }
    
    override func viewDidLoad() {
        goButton.layer.borderColor = UIColor.blackColor().CGColor
        goButton.layer.borderWidth = 2.0
        
        super.viewDidLoad()
        datePicker.minimumDate = NSDate()
        let components = NSDateComponents()
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endOfDay = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
        datePicker.maximumDate = endOfDay
    }
}