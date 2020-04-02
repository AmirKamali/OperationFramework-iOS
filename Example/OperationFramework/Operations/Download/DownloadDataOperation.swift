//
//  DownloadDataOperation.swift
//  SampleApplication
//
//  Created by Amir on 14/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

class DownloadDataOperation:ChainedOperation {
    var index:Int = 0
    override init() {
        super.init()
        executionBlock = downloadFile
    }
    
    func downloadFile(){
        guard let downloadProvider = self.operationInput as? DownloadOperationProvider else {
            return
        }
        let fileName = downloadProvider.downloadableFiles[index]
        print("Downloading ... \(fileName)")
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(2)) {
            print("Downloaded\(fileName)")
            downloadProvider.downloadedMessages.append("Downloaded Message \(self.index + 1)")
            DispatchQueue.main.async {
                self.onOperationComplete(operation: self)
            }
            
        }
        
        
        
        
    }
}
