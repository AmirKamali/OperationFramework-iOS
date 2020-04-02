//
//  TutorialOperationBuilder.swift
//  SampleApplication
//
//  Created by Amir on 8/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework
import UIKit

class TutorialOperationBuilderConfig:OperationBuilderConfig {
    var configName: String = "Config 1"
    var pageMessages:[String] = []
    
}
class TutorialOperationBuilder:OperationBuilderBase<TutorialOperationDataModel>,ChainedOperationDelegate{

    
    var canStart: ((ChainedOperation) -> Bool)?
    
    var shouldSkip: ((ChainedOperation) -> Bool)?
    
    init(config: TutorialOperationBuilderConfig? , navigationController: UINavigationController?) {
        super.init(config:config,navigationController:navigationController)
        addDelegate(delegate: self,delegateType: .internal)
        
        // Is there any presaved message in config? Save to operation provider
        dataModel.introductionMessages.append(contentsOf: config?.pageMessages ?? [])
        
        let pageComputeOperation = ChainedOperation()
        pageComputeOperation.executionBlock = {
            for messageIdx in 0 ..< self.totalMessages {
                let operation = TutorialMessageOperation()
                operation.index = messageIdx
                self.addOperation(operation: operation)
            }
            pageComputeOperation.onOperationComplete(operation: pageComputeOperation)
        }
        
        addOperation(operation: pageComputeOperation)
        
        
    }
    
    var totalMessages:Int{
        dataModel.introductionMessages.count
    }
    
    func onOperationComplete(operation: ChainedOperation) {
        if operation == operations.last {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func onOperationStart(operation: ChainedOperation) {
        print("starting...\(operation)")
    }
    
    func onOperationFailed(operation: ChainedOperation, error: Error) {
        print("failed...\(operation)")
    }
    
    func onOperationCancelled(operation: ChainedOperation) {
        print("cancelled...\(operation)")
    }
    
    func onBuilderRunComplete(operation: Any) {
          print("builder run complete...\(operation)")
    }
    
    deinit {
        print("Tutorial operation builder deinitialized")
    }
}

