//
//  DataTypes.swift
//  OperationFramework
//
//  Created by Amir on 8/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

public typealias dataHandler = ((_ responseData: Any?) -> Void)

public typealias errorHandler = ((_ error: Error) -> Void)

public typealias voidCallback = (() -> Void)

public let OperationFailedErrorCode = 100

public let OperationCancelledErrorCode = 101



public func OperationFailedError(reseon:String) -> Error
{
    return NSError(domain: reseon, code: OperationFailedErrorCode, userInfo: nil)
}

public func OperationCancelledError(reseon:String) -> Error
{
    return NSError(domain: reseon, code: OperationCancelledErrorCode, userInfo: nil)
}
