//
//  ReactorTests.swift
//  MVVMTests
//
//  Created by dean.anderson on 2020/08/10.
//  Copyright © 2020 Practice. All rights reserved.
//

@testable import MVVM
import XCTest

class ReactorTests: XCTestCase {

    private var reactor: ImageReactor!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() throws {
        let repository = ImageSuccessRepository()
        let useCase = DefaultImageSearchUseCase(repository: repository)
        reactor = ImageReactor(useCase: useCase)
        
        _ = reactor.state
            .compactMap{ $0.images.first }
            .take(1)
            .subscribe(onNext: { XCTAssertEqual($0.imageURL, repository.mock.imageURL) })
        
        _ = reactor.state
            .compactMap{ $0.error }
            .take(1)
            .subscribe(onNext: { _ in XCTFail() })
        
        reactor.action.onNext(.search(""))
    }
    
    func testFailure() throws {
        let repository = ImageFailureRepository()
        let useCase = DefaultImageSearchUseCase(repository: repository)
        reactor = ImageReactor(useCase: useCase)
         
        _ = reactor.state
            .compactMap{ $0.images }
            .take(1)
            .subscribe(onNext: {
                XCTAssert($0.isEmpty)
            })
         
         _ = reactor.state
             .compactMap{ $0.error }
             .take(1)
             .subscribe(onNext: { XCTAssertEqual($0, CustomError.unknown) })
         
         reactor.action.onNext(.search(""))
     }
}
