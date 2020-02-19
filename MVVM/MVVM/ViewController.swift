//
//  ViewController.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import RxSwift

final class ViewController: UIViewController {
    @IBOutlet private weak var mvvmButton: UIButton!
    @IBOutlet private weak var reactorkitButton: UIButton!
    
    private var coordinator: Coordinator?
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bind()
    }
    
    private func setup() {
        coordinator = Coordinator(navigationController: navigationController)
    }
    
    private func bind() {
        let mvvm = mvvmButton.rx.tap.asObservable().map{ Scene.mvvm }
        let reactorKit = reactorkitButton.rx.tap.asObservable().map{ Scene.reactorKit }
            
        Observable.merge(mvvm, reactorKit)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.show(scene: $0)
            })
            .disposed(by: disposeBag)
    }
}

