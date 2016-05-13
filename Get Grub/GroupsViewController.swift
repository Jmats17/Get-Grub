//
//  GroupsViewController.swift
//  Get Grub
//
//  Created by Justin Matsnev on 4/4/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GroupsViewController : UIViewController {
    
    @IBOutlet var tableView : UITableView!
    var ref = Firebase(url:"https://get-grub.firebaseio.com")
    var uid = NSUserDefaults.standardUserDefaults().valueForKey("uid")
    var groups : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //queryForGroups()
        //self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
//    func queryForGroups() {
//        
//        let groupRef = ref.childByAppendingPath("users/\(uid!)/groups")
//        groupRef.observeEventType(.ChildAdded, withBlock: {snapshot in
//            let groupKey = snapshot.key
//
//            self.ref.childByAppendingPath("groups/").observeSingleEventOfType(.Value, withBlock: {snapshot in
//                
//                let dict = snapshot.value as! NSDictionary
//                self.groups.addObject(dict.valueForKey(groupKey!)!)
//                for a in dict {
//                    if a == dict.valueForKey(groupKey!) {
//                        print(a)
//                    }
//                }
//                
//            })
//        })
//        self.tableView.reloadData()
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupsCell") as! GroupsCell
        let group = self.groups[indexPath.row]
        print(groups)

        cell.restaurantNameLabel.text = group.valueForKey("restaurantName") as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.groups.count)

        return groups.count
    }
    
    
    
    
    
    
    
    
    
    
    
    
}