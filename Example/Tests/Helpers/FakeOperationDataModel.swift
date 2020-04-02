//
//  FakeOperationDataModel.swift
//  OperationFrameworkTests
//
//  Created by Amir on 7/2/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

class FakeOperationDataModel:OperationBaseModel,UIOperationProvider, FakeOperationProvider{
    required init() {
        super.init()
        overalValue = 0
    }
}
