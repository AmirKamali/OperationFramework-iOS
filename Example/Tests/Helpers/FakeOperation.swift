//
//  FakeOperation.swift
//  OperationFrameworkTests
//
//  Created by Amir on 7/2/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

enum RunMode {
    case start
    case complete
    case failed
    case cancelled
    var runValue:Int {
        switch self {
        case .start:
            return 1
        case .complete:
            return 10
        case .failed:
            return 1000
        case .cancelled:
            return 10000
        }
    }
}

class FakeOperation:ChainedOperation {
    var runValue = 0
    private(set) var runMode:RunMode
    init(runMode:RunMode) {
        self.runMode = runMode
        super.init()
        executionBlock = fakeRun
    }
    private func fakeRun(){
        if let fakeOperationProvider = self.operationInput as? FakeOperationProvider {
            fakeOperationProvider.overalValue += runMode.runValue
        }
        switch runMode {
        case .complete:
            onOperationComplete(operation: self)
        case .failed:
            let error = NSError(domain:"", code:1000, userInfo:nil)
            onOperationFailed(error: error)
        case .cancelled:
            onOperationCancelled()
        case .start: break
           
        }
    }
}
