//
//  ImageSearchUseCase.swift
//  MVVM
//
//  Created by dean.anderson on 2021/04/09.
//  Copyright © 2021 Practice. All rights reserved.
//

import RxSwift

protocol ImageSearchUseCase {
    func search(text: String?) -> Observable<Swift.Result<[ImagePack], CustomError>>
}


final class DefaultImageSearchUseCase: ImageSearchUseCase {
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func search(text: String?) -> Observable<Result<[ImagePack], CustomError>> {
        repository.images(query: text)
    }
}
