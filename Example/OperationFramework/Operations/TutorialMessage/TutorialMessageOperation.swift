//
//  TutorialMessageOperation.swift
//  SampleApplication
//
//  Created by Amir on 10/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework
import UIKit

class TutorialMessageOperation:UIChainedOperation {
    var index:Int = 0
    override init() {
        super.init()
        executionBlock = navigateToTutorialMessagePage
    }
    func navigateToTutorialMessagePage(){
        guard let tutorialProvider = self.operationInput as? TutorialOperationProvider else {
            return
        }
        // Check for index out of range
        if (index >= tutorialProvider.introductionMessages.count) {
            return
        }
        
        // Initialize View Controller
        let vc = TutorialMessageViewController()
        vc.onCancelled = onCancelled
        vc.message = tutorialProvider.introductionMessages[index]
        
        // Add Navigation button
        let buttonName = index == tutorialProvider.introductionMessages.count - 1 ? "Finish" : "Next"
        let nextButton = UIBarButtonItem(title: buttonName, style: .plain, target: self, action: #selector(onNextButtonClicked))
        vc.navigationItem.rightBarButtonItem = nextButton
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Actions
    @objc
    func onNextButtonClicked(){
       onOperationComplete()
    }
    
    func onCancelled(){
        onOperationCancelled()
    }
}
