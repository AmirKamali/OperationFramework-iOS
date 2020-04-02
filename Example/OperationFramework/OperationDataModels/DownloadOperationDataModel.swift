//
//  DownloadOperationDataModel.swift
//  SampleApplication
//
//  Created by Amir on 14/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

class DownloadOperationDataModel:OperationBaseModel, DownloadOperationProvider {
    
    required init() {
        super.init()
        
        downloadableFiles = ["file1","file2","file3"]
        downloadedMessages = []
    }
}

