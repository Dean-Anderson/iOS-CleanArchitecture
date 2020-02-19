//
//  ImageViewModel.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import RxSwift

protocol ImageViewModelInputProviding {
    func search(keyword: String?)
}

protocol ImageViewModelOutputProviding {
    var results: Observable<Swift.Result<[ImagePack], CustomError>> { get }
}

protocol ImageViewModelProviding: ImageViewModelInputProviding, ImageViewModelOutputProviding {
    var input: ImageViewModelInputProviding { get }
    var output: ImageViewModelProviding { get }
}

final class ImageViewModel: ImageViewModelProviding {
    var input: ImageViewModelInputProviding { return self }
    var output: ImageViewModelProviding { return self }
    
    private let keywordSubject: PublishSubject<String?> = PublishSubject()
    
    var results: Observable<Swift.Result<[ImagePack], CustomError>>
    
    init(service: ImageServiceProviding) {
        results = keywordSubject.asObservable()
            .flatMapLatest{ service.images(query: $0) }
            .share()
    }
}

extension ImageViewModel {
    func search(keyword: String?) {
        keywordSubject.onNext(keyword)
    }
}
