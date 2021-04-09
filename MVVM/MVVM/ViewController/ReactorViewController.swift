//
//  ReactorViewController.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import ReactorKit
import RxSwift

final class ReactorViewController: UIViewController, StoryboardView {
    @IBOutlet private weak var searchKeywoard: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    fileprivate var coordinator: Coordinator?
    var reactor: ImageReactor? = nil
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    private func setup() {
        coordinator = Coordinator(navigationController: navigationController)
        tableView.register(UINib(nibName: ImageCell.className, bundle: nil), forCellReuseIdentifier: ImageCell.className)
    }
    
    func bind(reactor: ImageReactor) {
        searchKeywoard.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{ ImageReactor.Action.search($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map{ $0.images }
            .bind(to: tableView.rx.items(cellIdentifier: ImageCell.className, cellType: ImageCell.self)) { (row, image, cell) in
                cell.bind(drawable: image)
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        tableView.rx.modelSelected(ImageCellCreatable.self)
            .compactMap{ $0.linkURL }
            .map{ Scene.detail($0) }
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.show(scene: $0)
            })
            .disposed(by: disposeBag)
    }
}

extension ReactorViewController: VCBindFactory {
    static var storyboardIdentifier: String = ReactorViewController.className
    static var vcIdentifier: String = ""
    
    func bindData(value: Dependency) {
        reactor = ImageReactor.init(useCase: value.useCase)
    }
    
    struct Dependency {
        let useCase: ImageSearchUseCase
    }
}
