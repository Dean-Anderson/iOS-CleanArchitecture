//
//  ImageReactor.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/20.
//  Copyright © 2020 Practice. All rights reserved.
//

import ReactorKit
import RxSwift

final class ImageReactor: Reactor {
    enum Action {
        case search(String?)
    }
    
    enum Mutation {
        case images([ImagePack])
        case error(CustomError)
    }
    
    struct State {
        var images: [ImagePack] = []
        var error: CustomError?
    }
    
    var initialState: State = State()
    let service: ImageServiceProviding
    
    init(service: ImageServiceProviding) {
        self.service = service
    }
}

extension ImageReactor {
    func mutate(action: ImageReactor.Action) -> Observable<ImageReactor.Mutation> {
        switch action {
        case .search(let keyword):
            let result = service.images(query: keyword).share()
            let success = result.compactMap{ $0.success }.map{ Mutation.images($0) }
            let failure = result.compactMap{ $0.failure }.map{ Mutation.error($0) }
            return Observable.merge(success, failure)
        }
    }
    
    func reduce(state: ImageReactor.State, mutation: ImageReactor.Mutation) -> ImageReactor.State {
        var state = state
        
        switch mutation {
        case .images(let images):
            state.images = images
        case .error(let error):
            state.error = error
        }
        
        return state
    }
}
