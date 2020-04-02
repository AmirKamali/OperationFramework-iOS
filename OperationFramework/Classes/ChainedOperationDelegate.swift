//
//  ChainedOperationDelegate.swift
//  OperationFramework
//
//  Created by Amir on 30/3/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import Foundation

public protocol ChainedOperationDelegate {
    func onOperationStart(operation: ChainedOperation)
    
    func onOperationComplete(operation: ChainedOperation)
    
    func onOperationFailed(operation: ChainedOperation, error: Error)
    
    func onOperationCancelled(operation: ChainedOperation)
}

public protocol ChainedOperationControlDelegate: class {
    var canStart: ((ChainedOperation) -> Bool)? { get set }
    
    var shouldSkip: ((ChainedOperation) -> Bool)? { get set }
}
