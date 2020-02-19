//
//  DetailViewController.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    
    private let urlSubject: ReplaySubject<URL?> = ReplaySubject.create(bufferSize: 1)
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        urlSubject.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.imageView.sd_setImage(with: $0, completed: nil)
            })
            .disposed(by: disposeBag)
    }
}

extension DetailViewController: VCBindFactory {
    static var storyboardIdentifier: String = DetailViewController.className
    static var vcIdentifier: String = ""
    
    func bindData(value: URL?) {
        urlSubject.onNext(value)
    }
}
