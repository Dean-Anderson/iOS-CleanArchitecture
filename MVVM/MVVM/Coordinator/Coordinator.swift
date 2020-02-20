//
//  Coordinator.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import Foundation
import UIKit

enum Scene {
    case mvvm
    case reactorKit
    case detail(URL?)
}

protocol CoordinatorProviding {
    func show(scene: Scene)
}

final class Coordinator: CoordinatorProviding {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func show(scene: Scene) {
        let vc: UIViewController
        
        switch scene {
        case .mvvm:
            vc = MVVMViewController.createInstance()
        case .reactorKit:
            vc = ReactorViewController.createInstance()
        case .detail(let url):
            vc = DetailViewController.createInstance(url)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
