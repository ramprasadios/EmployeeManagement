//
//  ProfileHeaderView.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 28/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

protocol ImageChnageHandlerProtocol: class {
    func editImageTapped()
}

class ProfileHeaderView: UIView {
    
     weak var delegate: ImageChnageHandlerProtocol?

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userRoleLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTapGuesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTapGuesture()
    }
    
    func setTapGuesture() {
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(ProfileHeaderView.imageTapped))
        self.userImageView.addGestureRecognizer(tapGuesture)
    }
    
    @objc
    func imageTapped() {
        self.delegate?.editImageTapped()
    }
}
