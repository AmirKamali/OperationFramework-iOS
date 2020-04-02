//
//  UIChainedOperation.swift
//  GenericQuestions
//
//  Created by Amir Kamali on 25/12/19.
//  Copyright © 2019 Amir Kamali. All rights reserved.
//

import UIKit

public protocol UIOperationProvider: OperationProvider {
    
}

extension UIOperationProvider {
    
    var navigationController: UINavigationController? {
        get {
            let result: UINavigationController? = readData(forKey: "navigationController")
            return result }
        set { saveData(data: newValue, forKey: "navigationController") }
    }
    
}
