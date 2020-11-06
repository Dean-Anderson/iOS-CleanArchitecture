//
//  MVVMViewController.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import RxSwift

private protocol ViewModelBindable {
    var viewModel: ImageViewModel { get }
    var coordinator: Coordinator? { get }
    var disposeBag: DisposeBag { get }
    func bind(text: Observable<String?>, tableView: UITableView)
}

final class MVVMViewController: UIViewController {
    @IBOutlet private weak var searchKeywoard: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    fileprivate let viewModel: ImageViewModel = ImageViewModel(service: ImageService())
    fileprivate var coordinator: Coordinator?
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    private func setup() {
        coordinator = Coordinator(navigationController: navigationController)
        tableView.register(UINib(nibName: ImageCell.className, bundle: nil), forCellReuseIdentifier: ImageCell.className)
    }
    
    private func bind() {
        let textObservable = searchKeywoard.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
        
        bind(text: textObservable,
             tableView: tableView)
    }
}

extension MVVMViewController: ViewModelBindable {
    func bind(text: Observable<String?>, tableView: UITableView) {
        text
            .subscribe(onNext: { [weak viewModel] in
                viewModel?.input.search(keyword: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.results
            .compactMap{ $0.success }
            .bind(to: tableView.rx.items(cellIdentifier: ImageCell.className, cellType: ImageCell.self)) { (row, image, cell) in
                cell.set(url: image.thumbnailURL)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ImagePack.self)
            .compactMap{ $0.linkURL }
            .map{ Scene.detail($0) }
            .subscribe(onNext: { [weak coordinator] in
                coordinator?.show(scene: $0)
            })
            .disposed(by: disposeBag)
    }
}

extension MVVMViewController: VCFactory {
    static var storyboardIdentifier: String = MVVMViewController.className
    static var vcIdentifier: String = ""
}
