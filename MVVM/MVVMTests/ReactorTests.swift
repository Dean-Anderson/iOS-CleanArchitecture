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
        reactor = ImageReactor(service: ImageSuccessService())
        
        _ = reactor.state
            .map{ $0.images }
            .take(1)
            .subscribe(onNext: { XCTAssertEqual($0.count, 0) })
        
        _ = reactor.state
            .map{ $0.error }
            .take(1)
            .subscribe(onNext: { XCTAssertNil($0) })
        
        reactor.action.onNext(.search(""))
    }
    
    func testFailure() throws {
         reactor = ImageReactor(service: ImageFailureService())
         
         _ = reactor.state
             .compactMap{ $0.images }
             .take(1)
             .subscribe(onNext: { XCTAssertEqual($0.count, 0) })
         
         _ = reactor.state
             .compactMap{ $0.error }
             .take(1)
             .subscribe(onNext: { XCTAssertEqual($0, CustomError.unknown) })
         
         reactor.action.onNext(.search(""))
     }
}
