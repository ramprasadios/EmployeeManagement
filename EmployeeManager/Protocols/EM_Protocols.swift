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
