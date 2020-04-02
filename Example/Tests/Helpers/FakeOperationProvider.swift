//
//  FakeOperationProvider.swift
//  OperationFrameworkTests
//
//  Created by Amir on 7/2/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

protocol FakeOperationProvider: OperationProvider {
    
}
extension FakeOperationProvider {
    var overalValue: Int {
        get {
            let result: Int = readData(forKey: "overall_value") ?? 0
            return result
        }
        set { saveData(data: newValue, forKey: "overall_value") }
    }
}
