//
//  ChainedOperation.swift
//  OperationFramework
//
//  Created by Amir Kamali on 25/12/19.
//  Copyright © 2019 Amir Kamali. All rights reserved.
//

import UIKit
open class UIChainedOperation: ChainedOperation {
    public  var navigationController: UINavigationController? {
        return (self.operationInput as? UIOperationProvider)?.navigationController
    }
}

public protocol ChainedOperationProtocol: Hashable {
    var id:String {get}
    
    var isBusy:Bool {get set}
    
    var nextOperation: ChainedOperation? {get set}
    
    var operationInput:Any? {get set}
    
    var controlDelegate:ChainedOperationControlDelegate? {get set}
    
    func addDelegate(delegate:ChainedOperationDelegate)
    
    func start()
}

open class ChainedOperation:ChainedOperationProtocol {
    
    public var id = UUID().uuidString
    
    public var isBusy = false
    
    public var nextOperation: ChainedOperation?
    
    public var executionBlock: voidCallback?
    
    private var delegates: [ChainedOperationDelegate]?
    
    public var controlDelegate:ChainedOperationControlDelegate?
    
    public var _operationInput: Any?
    
    public var operationInput: Any? {
        get { return _operationInput }
        set {
            if _operationInput != nil , let newContainer = (newValue as? OperationBaseModel)?.container {
                (_operationInput as? OperationBaseModel)?.container = newContainer
            }
            else{
                _operationInput = newValue
            }
            
        }
    }
    public init(executionBlock: voidCallback? = nil) {
        self.executionBlock = executionBlock
    }
    
    public init() {
        
    }
    
    public func addDelegate(delegate:ChainedOperationDelegate){
        if  delegates == nil {
            delegates = []
        }
        self.delegates?.append(delegate)
    }
    
    public func start(){
        DispatchQueue.main.async {
            if !(self.controlDelegate?.canStart?(self) ?? true) {
                let error = OperationFailedError(reseon: "Can not start operation \(self.id)")
                self.delegates?.forEach{$0.onOperationFailed(operation: self, error: error)}
                return
            }
            if self.controlDelegate?.shouldSkip?(self) ?? false {
                self.delegates?.forEach{$0.onOperationComplete(operation: self)}
                return
            }
            self.delegates?.forEach{$0.onOperationStart(operation: self)}
            self.executionBlock?()
        }
    }
    
    func freeup() {
        self.nextOperation = nil
        self.delegates = nil
        self.executionBlock = nil
        self.delegates?.removeAll()
    }
    
    deinit {
        #if DEBUG
        print("deinitializing operation :\(self) with id:\(id)")
        #endif
    }
    
}

extension ChainedOperation:Hashable {
    public static func == (lhs: ChainedOperation, rhs: ChainedOperation) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ChainedOperation
{
    public func onOperationStart(){
        delegates?.forEach{$0.onOperationStart(operation: self)}
    }
    
    public func onOperationComplete(operation:ChainedOperation? = nil){
        delegates?.forEach{$0.onOperationComplete(operation: operation ?? self)}
    }
    
    public func onOperationCancelled(){
        delegates?.forEach{$0.onOperationCancelled(operation: self)}
    }
    
    public func onOperationFailed(error:Error){
        delegates?.forEach{$0.onOperationFailed(operation: self,error: error)}
    }
    
}
