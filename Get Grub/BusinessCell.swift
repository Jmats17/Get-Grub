//
//  BusinessCell.swift
//  Yelp
//
//  Created by Chirag Davé on 4/26/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var numReviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dollarsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFields(business: Business!) {
        if let imageURL = business.imageURL {
            restaurantImage.setImageWithURL(imageURL)
        }
        
        if let imageURL = business.ratingImageURL {
            reviewImage.setImageWithURL(business.ratingImageURL!)
        }
        
        nameLabel.text = business.name
        numReviewsLabel.text = "\(business.reviewCount!) reviews"
        addressLabel.text = "\(business.address!), \(business.city!),\(business.state!) \(business.zipCode!)"
        categoryLabel.text = business.categories
        distanceLabel.text = business.distance
        
        dollarsLabel.text = "$$"
    }

}
