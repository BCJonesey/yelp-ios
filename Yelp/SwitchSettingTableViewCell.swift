//
//  SwitchSettingTableViewCell.swift
//  Yelp
//
//  Created by Ben Jones on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol SwitchSettingTableViewCellDelegate: class {
    func switchSettingsCellDidToggle(cell: SwitchSettingTableViewCell, newValue:Bool)
}

class SwitchSettingTableViewCell: UITableViewCell {

    var category : String = ""
    var value : String = ""
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    weak var delegate: SwitchSettingTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func switchValueChanged(_ sender: AnyObject) {
        delegate?.switchSettingsCellDidToggle(cell: self, newValue: switchControl.isOn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
