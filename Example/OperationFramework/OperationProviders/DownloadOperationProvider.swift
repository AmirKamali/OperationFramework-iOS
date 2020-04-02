//
//  DownloadOperationProvider.swift
//  SampleApplication
//
//  Created by Amir on 14/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import OperationFramework

protocol DownloadOperationProvider: OperationProvider {
    
}
extension DownloadOperationProvider {
    var downloadableFiles: [String] {
        get {
            let result: [String]? = readData(forKey: "downloadableFiles")
            return result ?? [] }
        set { saveData(data: newValue, forKey: "downloadableFiles") }
    }
    var downloadedMessages:[String] {
        get {
            let result: [String]? = readData(forKey: "downloadedMessages")
            return result ?? [] }
        set { saveData(data: newValue, forKey: "downloadedMessages") }
    }
}
