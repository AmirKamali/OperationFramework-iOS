//
//  ReadContentOperation.swift
//  SampleApplication
//
//  Created by Amir Kamali on 14/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

class ReadContentOperation:ChainedOperation {
    override init() {
        super.init()
        executionBlock = readContent
    }
    func readContent(){
        guard let downloadProvider = self.operationInput as? DownloadOperationProvider else {
            return
        }
        guard let tutorialProvider = self.operationInput as? TutorialOperationProvider else {
            return
        }
        
        // Read content and transfer to tutorial messages
        for item in downloadProvider.downloadedMessages {
            tutorialProvider.introductionMessages.append(item)
        }
        print("read content complete")
        onOperationComplete(operation: self)
    }
}

