//
//  DownloadOperationBuilder.swift
//  SampleApplication
//
//  Created by Amir on 14/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework
import UIKit

class DownloadOperationBuilder:OperationBuilderBase<DownloadOperationDataModel>,ChainedOperationDelegate{
    
    var canStart: ((ChainedOperation) -> Bool)?
    var shouldSkip: ((ChainedOperation) -> Bool)?
    var waitingIndiactor:UIActivityIndicatorView!
    var currentViewController:UIViewController?
    init(currentViewController:UIViewController?) {
        super.init(config:nil,navigationController:nil)
        addDelegate(delegate: self,delegateType: .internal)
        self.currentViewController = currentViewController
        waitingIndiactor = UIActivityIndicatorView(style: .medium)
        waitingIndiactor.hidesWhenStopped = true
        currentViewController?.view.addSubview(waitingIndiactor)
        waitingIndiactor.center = currentViewController?.view.center ?? .zero
        
        // Save to operation provider
        for fileIdx in 0 ..< dataModel.downloadableFiles.count {
            let operation = DownloadDataOperation()
            operation.index = fileIdx
            addOperation(operation: operation)
        }
        
    }
    
    func onOperationComplete(operation: ChainedOperation) {
        print("completed...\(operation)")
        if operation == operations.last {
            self.waitingIndiactor?.stopAnimating()
        }
    }
    
    func onOperationStart(operation: ChainedOperation) {
        print("starting...\(operation)")
        if (operation == operations.first) {
            self.waitingIndiactor.startAnimating()
        }
    }
    
    func onOperationFailed(operation: ChainedOperation, error: Error) {
        print("failed...\(operation)")
        //   waitingIndiactor?.stopAnimating()
    }
    
    func onOperationCancelled(operation: ChainedOperation) {
        print("cancelled...\(operation)")
    }
   
    deinit {
        print("Download Operation Builder deinitialized")
    }
}
