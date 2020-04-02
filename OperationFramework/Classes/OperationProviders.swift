//
//  OperationProviders.swift
//  GenericQuestions
//
//  Created by Amir Kamali on 25/12/19.
//  Copyright © 2019 Amir Kamali. All rights reserved.
//

import Foundation


public protocol OperationProvider: class {
    init()

    var container:OperationBaseModelDataContainer {get set}
    
}
extension OperationProvider {
    
    public func saveData(data: Any?, forKey: String) {
        dataDictionary[forKey] = data
    }
    
    public func readData<T>(forKey: String) -> T? where T: Codable {
        if let data = dataDictionary[forKey] as? T {
            return data
        }
        return nil
    }
    
    public func readData<T>(forKey: String) -> T? where T: RawRepresentable, T.RawValue == Int {
        if let data = dataDictionary[forKey] as? T {
            return data
        }
        return nil
    }
    
    public func readData<T>(forKey: String) -> T? where T: RawRepresentable, T.RawValue == String {
        if let data = dataDictionary[forKey] as? T {
            return data
        }
        return nil
    }
    
    public func readData<T>(forKey: String) -> T? where T: Any {
        if !dataDictionary.keys.contains(forKey) {
            return nil
        }
        if let data = dataDictionary[forKey] {
            return data as? T
        }
        return nil
    }
    
    
}


