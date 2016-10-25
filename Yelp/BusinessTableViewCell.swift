//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Ben Jones on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var businessImage: UIImageView!
    
    var business : Business?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func repaint() {
        if let business = self.business{
            nameLabel.text = business.name
            if let imageUrl = business.imageURL {
                businessImage.setImageWith(imageUrl)
            }
            
        }
    }
    

}
