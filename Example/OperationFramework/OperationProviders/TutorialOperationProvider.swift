//
//  OperationProvider+Properties.swift
//  GenericQuestions
//
//  Created by Amir Kamali on 26/12/19.
//  Copyright © 2019 Amir Kamali. All rights reserved.
//

import OperationFramework

protocol TutorialOperationProvider: OperationProvider {

}
extension TutorialOperationProvider {
    var introductionMessages: [String] {
        get {
            let result: [String]? = readData(forKey: "introduction_messages")
            return result ?? [] }
        set { saveData(data: newValue, forKey: "introduction_messages") }
    }
}
