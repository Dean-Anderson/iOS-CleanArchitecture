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
    case mvvm(Environment)
    case reactorKit(Environment)
    case detail(URL?)
}

enum Environment {
    case normal
    case success
    case failure
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
        case .mvvm(let environment):
            let useCase = ImageSearchUseCaseFactory.create(environment: environment)
            vc = MVVMViewController.createInstance(.init(useCase: useCase))
        case .reactorKit(let environment):
            let useCase = ImageSearchUseCaseFactory.create(environment: environment)
            vc = ReactorViewController.createInstance(.init(useCase: useCase))
        case .detail(let url):
            vc = DetailViewController.createInstance(url)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
