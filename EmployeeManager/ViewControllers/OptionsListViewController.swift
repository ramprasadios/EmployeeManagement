//
//  OptionsListViewController.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 25/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import UIKit

class OptionsListViewController: UIViewController {
    
    @IBOutlet weak var optionsListTableView: UITableView!
    @IBOutlet weak var optionViewHeight: NSLayoutConstraint!
    
    weak var optionsListDelegate: ModelPresentable?
    
    var optionsViewModel = OptionsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.optionViewHeight.constant = CGFloat(optionsViewModel.dailogueHeight)
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func animateCell(_ cell: UITableViewCell) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.modalPresentationStyle = .overCurrentContext
    }
}

extension OptionsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.optionsViewModel.optionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsListCell", for: indexPath)
        cell.textLabel?.text = self.optionsViewModel.optionsArray[indexPath.row]
        animateCell(cell)
        return cell
    }
}

extension OptionsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        self.optionsListDelegate?.selectedType(with: self.optionsViewModel.optionsArray[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
