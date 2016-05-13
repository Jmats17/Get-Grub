//
//  GroupsCell.swift
//  Get Grub
//
//  Created by Justin Matsnev on 4/4/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit

class GroupsCell : UITableViewCell {
    
    @IBOutlet var restaurantNameLabel : UILabel!
    @IBOutlet var timeLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}