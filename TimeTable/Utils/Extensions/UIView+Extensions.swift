//
//  UIView+Extensions.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

import UIKit

extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
