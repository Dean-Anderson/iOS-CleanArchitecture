//
//  ViewModelTests.swift
//  MVVMTests
//
//  Created by dean.anderson on 2020/08/10.
//  Copyright © 2020 Practice. All rights reserved.
//

@testable import MVVM
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
        let repository = ImageSuccessRepository()
        let useCase = DefaultImageSearchUseCase(repository: repository)
        viewModel = ImageViewModel(useCase: useCase)
        
        _ = viewModel.output.imageCellCreatables
            .take(1)
            .subscribe(onNext: {
                XCTAssertEqual($0.count, 1)
                let pack = $0.first!
                XCTAssertEqual(pack.imageURL, repository.mock.imageURL)
            })
            
        _ = viewModel.output.error
            .take(1)
            .subscribe(onNext: { _ in try? TestError.throwError() })
        
        viewModel.input.search(keyword: "")
    }
    
    func testFailureViewModel() throws {
        let repository = ImageFailureRepository()
        let useCase = DefaultImageSearchUseCase(repository: repository)
        viewModel = ImageViewModel(useCase: useCase)
        
        _ = viewModel.output.imageCellCreatables
            .take(1)
            .subscribe(onNext: { _ in XCTFail() })
            
        _ = viewModel.output.error
            .take(1)
            .subscribe(onNext: { XCTAssertEqual($0, CustomError.unknown) })
        
        viewModel.input.search(keyword: "")
    }
}
