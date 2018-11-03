//
//  EmployeeTableViewCell.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 03/11/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
