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
    var imageCellCreatables: Observable<[ImageCellCreatable]> { get }
    var error: Observable<CustomError> { get }
}

protocol ImageViewModelProviding: ImageViewModelInputProviding, ImageViewModelOutputProviding {
    var input: ImageViewModelInputProviding { get }
    var output: ImageViewModelProviding { get }
}

final class ImageViewModel: ImageViewModelProviding {
    var input: ImageViewModelInputProviding { return self }
    var output: ImageViewModelProviding { return self }
    
    private let keywordSubject: PublishSubject<String?> = PublishSubject()
    
    let imageCellCreatables: Observable<[ImageCellCreatable]>
    let error: Observable<CustomError>
    
    init(useCase: ImageSearchUseCase) {
        let search = keywordSubject.asObservable()
            .flatMapLatest{ useCase.search(text: $0) }
            .share()
        
        imageCellCreatables = search.compactMap{ $0.success }
        
        error = search.compactMap{ $0.failure }
    }
}

extension ImageViewModel {
    func search(keyword: String?) {
        keywordSubject.onNext(keyword)
    }
}
