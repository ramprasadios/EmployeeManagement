//
//  OptionsListViewModel.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 25/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation

class OptionsListViewModel {
    
    var optionsArray: [String]!
    var isMultiSelectable: Bool?
    
    var dailogueHeight: Double {
        let height = Double(self.optionsArray.count * 44) + 10.0
        return (height > 150) ? 150.0 : height
    }
    
}
