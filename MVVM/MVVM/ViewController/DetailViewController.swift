//
//  DetailViewController.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import RxSwift
import RxCocoa
import WebKit

final class DetailViewController: UIViewController {
    @IBOutlet private weak var webViewContainer: UIView!
    
    private let webView: WKWebView = WKWebView()
    private let urlSubject: ReplaySubject<URL?> = ReplaySubject.create(bufferSize: 1)
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    private func setup() {
        webViewContainer.addSubviewWithFit(webView)
    }
    
    private func bind() {
        urlSubject.asObservable()
            .compactMap{ $0 }
            .map{ URLRequest(url: $0) }
            .subscribe(onNext: { [weak self] in
                self?.webView.load($0)
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
