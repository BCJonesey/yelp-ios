//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Ben Jones on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessTableViewCell: UITableViewCell {

    var business : Business?
    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var numRatingsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func repaint() {
        if let business = business {
            businessImage.setImageWith(business.imageURL!)
            businessImage.layer.cornerRadius = 5;
            businessImage.clipsToBounds = true;
            titleLabel.text = business.name
            starsImage.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance
            numRatingsLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
            
            
        }
        
    }
  
    func imageForStars(starHalves:Int) -> UIImage {
        let image = #imageLiteral(resourceName: "stars_map")
        let cropSquare = CGRect(x: 0, y: 0, width: 132, height: 25)
        
        
    

        let imageRef = image.cgImage!.cropping(to: cropSquare);
        
        
        return UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
        
        
        
        
    }
    
}
