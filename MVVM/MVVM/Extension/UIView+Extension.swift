//
//  UIView+Extension.swift
//  MVVM
//
//  Created by dean.anderson on 2020/11/08.
//  Copyright © 2020 Practice. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewWithFit(_ subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.frame = self.bounds
        self.addSubview(subView)
        
        [NSLayoutConstraint.Attribute.top,
         NSLayoutConstraint.Attribute.bottom,
         NSLayoutConstraint.Attribute.leading,
         NSLayoutConstraint.Attribute.trailing]
            .map { attribute in
                NSLayoutConstraint(item: subView, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1.0, constant: 0)
            }
            .forEach(self.addConstraint)
    }
    
    func removeSubviews() {
        for view in subviews { view.removeFromSuperview() }
    }
}
