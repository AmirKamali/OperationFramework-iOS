//
//  AdvancedExampleOperationBuilder.swift
//  SampleApplication
//
//  Created by Amir Kamali on 14/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework
import UIKit

class AdvancedExampleOperationBuilder:OperationBuilderBase<AdvancedExampleOperationDataModel>,ChainedOperationDelegate{
    
    
    
    var canStart: ((ChainedOperation) -> Bool)?
    
    var shouldSkip: ((ChainedOperation) -> Bool)?
    
    init(navigationController:UINavigationController?) {
        super.init(config:nil,navigationController:navigationController)
        addDelegate(delegate: self)
        // Save to operation provider
        
        let operation1_downloadContent = DownloadOperationBuilder(currentViewController: navigationController?.topViewController)
        let operation2_readDownloadedContent = ReadContentOperation()
        let operation3_NavigateContent = TutorialOperationBuilder(config: .none, navigationController: navigationController)
        
        addOperation(operation: operation1_downloadContent)
        addOperation(operation: operation2_readDownloadedContent)
        addOperation(operation: operation3_NavigateContent)
        
        
        
    }
    
    func onOperationComplete(operation: ChainedOperation) {
        if (operations.last == operation) {
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
        print("Download Operation Builder deinitialized")
    }
}
