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
    var groups : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryForGroups()
        //print(groups)
    }
    
    func queryForGroups() {
        
        let groupRef = ref.childByAppendingPath("users/\(uid!)/groups")
        groupRef.observeEventType(.ChildAdded, withBlock: {snapshot in
            let groupKey = snapshot.key

            self.ref.childByAppendingPath("groups/").observeSingleEventOfType(.Value, withBlock: {snapshot in
                
                print(snapshot.value)
//                for value in (snapshot.value as! Array) {
//                    print(value)
//                }
                
            })
        })
    }
    
}