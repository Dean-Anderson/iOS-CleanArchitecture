//
//  VCFactory.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import UIKit

protocol VCFactory: class {
    static var storyboardIdentifier: String { get }
    static var vcIdentifier: String { get }
}

protocol VCBindFactory: VCFactory {
    associatedtype Dependency
    func bindData(value: Dependency)
}

extension VCFactory {
    static func createInstance() -> Self {
        if self.vcIdentifier.isEmpty {
            return UIStoryboard(name: self.storyboardIdentifier, bundle: nil).instantiateInitialViewController() as! Self
        } else {
            return UIStoryboard(name: self.storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: self.vcIdentifier) as! Self
        }
    }
}

extension VCBindFactory {
    static func createInstance(_ initial: Self.Dependency) -> Self {
        if self.vcIdentifier.isEmpty {
            let vc = UIStoryboard(name: self.storyboardIdentifier, bundle: nil).instantiateInitialViewController() as! Self
            vc.bindData(value: initial)
            return vc
        } else {
            let vc = UIStoryboard(name: self.storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: self.vcIdentifier) as! Self
            vc.bindData(value: initial)
            return vc
        }
    }
}
