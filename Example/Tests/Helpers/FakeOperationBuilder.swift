//
//  FakeOperationBuilder.swift
//  OperationFrameworkTests
//
//  Created by Amir on 7/2/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

class FakeOperationBuilder:OperationBuilderBase<FakeOperationDataModel>{
    
   
    init(delegate:ChainedOperationDelegate?) {
        super.init(config: nil, navigationController: nil)
        if let delegate = delegate {
            self.addDelegate(delegate: delegate, delegateType: .internal)
        }
        
        for _ in 0 ..< 5 {
            addOperation(operation: FakeOperation(runMode: .complete))
        }
        
        
    }
  
    
    
    
}
