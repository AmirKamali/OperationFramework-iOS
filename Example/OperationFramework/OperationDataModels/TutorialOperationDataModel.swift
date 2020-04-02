//
//  OnBoardingOperationDataModel.swift
//  SampleApplication
//
//  Created by Amir on 8/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

class TutorialOperationDataModel:OperationBaseModel,UIOperationProvider, TutorialOperationProvider{
    
    required init() {
        super.init()
        
        introductionMessages = []
    }
}
