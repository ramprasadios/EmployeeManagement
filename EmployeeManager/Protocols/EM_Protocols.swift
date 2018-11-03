//
//  EM_Protocols.swift
//  EmployeeManager
//
//  Created by Ramprasad A on 25/10/18.
//  Copyright © 2018 Ramprasad A. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewUpdatable: class {
    func updateUI()
}

protocol ModelPresentable: class {
    func selectedType(with text: String)
}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UIView: NibLoadableView {}


protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }

protocol EnumIteratable {
    
    func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T>
}

extension EnumIteratable {
    
    func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) {
                $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
            }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
}

protocol AlertDisplayable {
    
    func showAlert(title: String, message: String?, okActionTitle: String,handler:((UIAlertAction) -> Void)?)
    func showConfirmationAlert(title: String, message: String, okActionTitle: String,cancelTitle: String,confirmationHandler:@escaping ((_ clickedAlertAction: UIAlertAction, _ isDestructiveAction: Bool ) -> Void))
}

extension AlertDisplayable where Self: UIViewController  {
    
    func showAlert(title: String, message: String?, okActionTitle: String,handler:((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: handler)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirmationAlert(title: String, message: String, okActionTitle: String,cancelTitle: String,confirmationHandler:@escaping ((_ clickedAlertAction: UIAlertAction, _ isDestructiveAction: Bool ) -> Void)) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .destructive, handler: { action in
            confirmationHandler(action, true)
        })
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: { action in
            confirmationHandler(action, false)
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
