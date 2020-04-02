//
//  OperationBaseModel.swift
//  OperationFramework
//
//  Created by Amir on 1/4/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import Foundation

public class OperationBaseModelDataContainer {
    
    public var dataDictionary: [String: Any] = [:]
    
}

extension OperationProvider {
    
    var dataDictionary: [String: Any] {
        get {
            return container.dataDictionary
        } set {
            container.dataDictionary = newValue
        }
    }
}

open class OperationBaseModel: OperationProvider {
    
    public var container = OperationBaseModelDataContainer()
    
    required public init() {
        
    }
}
