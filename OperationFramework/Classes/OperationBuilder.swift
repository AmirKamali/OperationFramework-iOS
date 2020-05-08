//
//  OperationBuilder.swift
//  GenericQuestions
//
//  Created by Amir Kamali on 25/12/19.
//  Copyright © 2019 Amir Kamali. All rights reserved.
//
import UIKit

public protocol OperationBuilderConfig {
    var configName: String { get }
}

public protocol OperationBuilderProtocol:ChainedOperationProtocol {
    //associatedtype T
    // var dataModel: T { get set }
    var operations: [ChainedOperation] { get set }
    func addDelegate(delegate: ChainedOperationDelegate, delegateType: OperationBuilderDelegateType)
    
}

public enum OperationBuilderDelegateType {
    case `internal`
    case external
    
}

open class OperationBuilderBase<T>:ChainedOperation, OperationBuilderProtocol where T: OperationProvider {
    
    public var dataModel: T
    
    public var builderDelegate:DefaultOperationBuilderDelegate<T>?
    
    fileprivate var internalDelegates:[ChainedOperationDelegate] = []
    
    fileprivate var externalDelegates:[ChainedOperationDelegate] = []
    
    public var operations: [ChainedOperation] = []
    
    
    public init(config: OperationBuilderConfig?, navigationController: UINavigationController?) {
        
        dataModel = T()
        super.init()
        id = UUID().uuidString
        let builderDelegate = DefaultOperationBuilderDelegate(operationBuilder: self)
        self.builderDelegate = builderDelegate
        addDelegate(delegate: builderDelegate,delegateType: .internal)
        commonInit(navigationController: navigationController)
        
    }
    
    public func addDelegate(delegate: ChainedOperationDelegate, delegateType: OperationBuilderDelegateType) {
        if delegateType == .external {
            externalDelegates.append(delegate)
        }else {
            internalDelegates.append(delegate)
            operations.forEach{$0.addDelegate(delegate: delegate)}
        }
    }
    
    public override func addDelegate(delegate: ChainedOperationDelegate) {
        addDelegate(delegate: delegate, delegateType: .external)
    }
    
    private func commonInit(navigationController: UINavigationController?) {
        if let uiOperationModel = dataModel as? UIOperationProvider {
            
            //UI Provider represents AnalyticsFlow so lets let the analytics manage know the flow
            if (navigationController != nil) {
                uiOperationModel.navigationController = navigationController
            } else if dataModel is UINavigationController{
                fatalError("Navigation Controller not set. use the init(context:navigationController:)")
            }
        }
        operationInput = dataModel
    }
    
    open override func start() {
        if !operations.isEmpty {
            self.operations[0].start()
        }
    }
    
    public func addOperation(operation: ChainedOperation) {
        internalDelegates.forEach{operation.addDelegate(delegate: $0)}
        if let lastOperation = operations.last{
            lastOperation.nextOperation = operation
        }
        operation.operationInput = dataModel
        operations.append(operation)
    }
    
    public func insertOperation(atIndex: Int, operation: ChainedOperation) {
        internalDelegates.forEach{operation.addDelegate(delegate: $0)}
        var insertIdx = atIndex
        if (insertIdx >= operations.count) {
            insertIdx = operations.count
            addOperation(operation: operation)
            return
        }
        
        operations.insert(operation, at: insertIdx)
        operations[insertIdx].nextOperation = operations[insertIdx + 1]
        if (insertIdx != 0) {
            operations[insertIdx - 1].nextOperation = operation
            return
        }
    }
    
    public func removeOperation(atIndex: Int) {
        if ( atIndex > operations.count - 1 ) {
            return
        }
        let removedOperation = operations.remove(at: atIndex)
        removedOperation.freeup()
        if (atIndex > operations.count - 1) {
            return
        }
        let shiftedOperation = operations[atIndex]
        let previousOperation = operations[atIndex - 1]
        
        previousOperation.nextOperation = shiftedOperation
    }
    
    public func removeOperation<T>(operationType: T.Type) {
        var i = 0
        while i < operations.count {
            if operations[i] is T {
                let operation = operations.remove(at: i)
                operation.freeup()
                if i > 0 && operation.nextOperation != nil {
                    operations[i - 1].nextOperation = operation.nextOperation
                }
                i -= 1
            }
            i += 1
        }
    }
    
    public var navigationController: UINavigationController? {
        if let navigationProvider = dataModel as? UIOperationProvider {
            return navigationProvider.navigationController
        }
        return nil
    }
    
}

public class DefaultOperationBuilderDelegate<T>:ChainedOperationDelegate where T:OperationProvider{
    
    let operationBuilder:OperationBuilderBase<T>
    
    public  init(operationBuilder:OperationBuilderBase<T>) {
        self.operationBuilder = operationBuilder
    }
    
    // MARK:- Delegtes
    public func onOperationStart(operation: ChainedOperation) {
        if operation == operationBuilder.operations.first {
            operationBuilder.externalDelegates.forEach{$0.onOperationStart(operation: operationBuilder)}
        }
    }
    public func onOperationComplete(operation: ChainedOperation) {
        
        if operation == operationBuilder.operations.last {
            operationBuilder.externalDelegates.forEach{$0.onOperationComplete(operation: operationBuilder)}
        }
        
        let nextOperation = operation.nextOperation
        
        //Pass data model
        nextOperation?.operationInput = operation.operationInput
        nextOperation?.start()
    }
    
    public func onOperationFailed(operation: ChainedOperation, error: Error) {
        if operation == operationBuilder.operations.first {
            operationBuilder.externalDelegates.forEach{$0.onOperationFailed(operation: operationBuilder,error: error)}
        }
    }
    
    public func onOperationCancelled(operation: ChainedOperation) {
        if operation == operationBuilder.operations.first {
            operationBuilder.externalDelegates.forEach{$0.onOperationCancelled(operation: operationBuilder)}
        }
    }
}
