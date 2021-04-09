//
//  ImageSearchUseCaseFactory.swift
//  MVVM
//
//  Created by dean.anderson on 2021/04/09.
//  Copyright © 2021 Practice. All rights reserved.
//

enum ImageSearchUseCaseFactory {
    static func create(environment: Environment) -> ImageSearchUseCase {
        let repository: ImageRepository
        switch environment {
        case .normal:
            repository = ImageServerRepository()
        case .success:
            repository = ImageSuccessRepository()
        case .failure:
            repository = ImageFailureRepository()
        }
        
        return DefaultImageSearchUseCase(repository: repository)
    }
}
