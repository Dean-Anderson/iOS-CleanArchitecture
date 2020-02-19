//
//  APIClient.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import Alamofire

final class APIClient {
    static let instance: APIClient = APIClient()
    let session: Session
    
    private init() {
        session = APIClient.createSession()
    }
    
    private static func createSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Configuration.timeout
        configuration.timeoutIntervalForResource = Configuration.timeout
        
        return Session(configuration: configuration)
    }
}
