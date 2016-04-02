//
//  GroupGrubViewController.swift
//  Get Grub
//
//  Created by Justin Matsnev on 3/28/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GroupGrubViewController : UIViewController {
    
    var ref = Firebase(url:"https://get-grub.firebaseio.com")

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}