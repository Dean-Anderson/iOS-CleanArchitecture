//
//  ImageRepository.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import RxSwift
import Alamofire
import SwiftyJSON

protocol ImageRepository {
    func images(query: String?) -> Observable<Swift.Result<[ImagePack], CustomError>>
}

struct ImageServerRepository: ImageRepository {
    func images(query: String?) -> Observable<Swift.Result<[ImagePack], CustomError>> {
        guard let safeQuery = query,
            safeQuery.count > 0 else {
                return Observable.just(.success([]))
        }
        
        let path = "\(Configuration.domain)\(Version.v1.rawValue)?key=\(Configuration.apiKey)&cx=013192398778145171751:ypdvo853wcg&q=\(safeQuery)&searchType=image"
        
        return Observable.create { observer -> Disposable in
            let reqeust = APIClient.instance.session.request(path, method: .get)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let result = JSON(value)
                        let items = result["items"].arrayValue.map(ImagePack.init)
                        observer.onNext(.success(items))
                        observer.onCompleted()
                    case .failure:
                        observer.onError(CustomError.unknown)
                    }
            }
            
            return Disposables.create{ reqeust.cancel() }
        }
    }
}

enum CustomError: Error {
    case unknown
}
