//
//  ViewModelTests.swift
//  MVVMTests
//
//  Created by dean.anderson on 2020/08/10.
//  Copyright © 2020 Practice. All rights reserved.
//

@testable import MVVM
import RxSwift
import XCTest

class ViewModelTests: XCTestCase {

    enum TestError: Error {
        case unexpected
        
        static func throwError() throws {
            throw TestError.unexpected
        }
    }
    
    private var viewModel: ImageViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccess () throws {
        let service = ImageSuccessService()
        viewModel = ImageViewModel(service: service)
        
        _ = viewModel.output.results
            .compactMap{ $0.success }
            .take(1)
            .subscribe(onNext: {
                XCTAssertEqual($0.count, 1)
                let pack = $0.first!
                XCTAssertEqual(pack, service.mock)
            })
            
        _ = viewModel.output.results
            .compactMap{ $0.failure }
            .take(1)
            .subscribe(onNext: { _ in try? TestError.throwError() })
        
        viewModel.input.search(keyword: "")
    }
    
    func testFailureViewModel() throws {
        viewModel = ImageViewModel(service: ImageFailureService())
        
        _ = viewModel.output.results
            .compactMap{ $0.success }
            .take(1)
            .subscribe(onNext: { XCTAssertEqual($0.count, 0) })
            
        _ = viewModel.output.results
            .compactMap{ $0.failure }
            .take(1)
            .subscribe(onNext: { XCTAssertEqual($0, CustomError.unknown) })
        
        viewModel.input.search(keyword: "")
    }
}
