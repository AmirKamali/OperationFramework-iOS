//
//  AdvancedExampleOperationDataModel.swift
//  SampleApplication
//
//  Created by Amir Kamali on 14/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

class AdvancedExampleOperationDataModel:OperationBaseModel, DownloadOperationProvider,UIOperationProvider, TutorialOperationProvider {
    
    required init() {
        super.init()
        downloadableFiles = ["Address 1","Address 2","Address 3"]
    }
}
