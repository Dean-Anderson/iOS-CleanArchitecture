//
//  Result+Extension.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

extension Swift.Result {
    var success: Success? {
        if case .success(let success) = self { return success }
        return nil
    }
    
    var failure: Failure? {
        if case .failure(let failure) = self { return failure }
        return nil
    }
}
