//
//  OptionsTableViewCell.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 28/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var optionCellImageView: UIImageView!
    @IBOutlet weak var optionTypeLabel: UILabel!
    @IBOutlet weak var optionDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
