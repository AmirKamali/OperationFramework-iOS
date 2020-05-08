//
//  OperationFrameworkTests.swift
//  OperationFrameworkTests
//
//  Created by Amir on 8/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import XCTest
@testable import OperationFramework




class OperationFrameworkTests: XCTestCase,ChainedOperationDelegate,ChainedOperationControlDelegate {
    
    var runValue:Int = 0
    var runExpectation:XCTestExpectation?
    var shouldSkip: ((ChainedOperation) -> Bool)?
    var shouldStart: ((ChainedOperation) -> Bool)?


    
    func onOperationStart(operation: ChainedOperation) {
        runValue += RunMode.start.runValue
    }
    
    func onOperationComplete(operation: ChainedOperation) {
        runValue += RunMode.complete.runValue
        runExpectation?.fulfill()
    }
    
    func onOperationFailed(operation: ChainedOperation, error: Error) {
        runValue += RunMode.failed.runValue
        runExpectation?.fulfill()
    }
    
    func onOperationCancelled(operation: ChainedOperation) {
        runValue += RunMode.cancelled.runValue
        runExpectation?.fulfill()
        
    }
    
    

    
    
    func testOperationDelegateComplete() {
        let mode:RunMode = .complete
        let operation = FakeOperation(runMode: mode)
        operation.addDelegate(delegate: self)
        runExpectation =  expectation(description: "operation with Value\(mode.runValue)")
        operation.start()
        
        wait(for: [runExpectation!], timeout: 1)
        XCTAssertEqual(self.runValue, RunMode.start.runValue + mode.runValue)
    }
    
    func testOperationDelegateFailed() {
        let mode:RunMode = .failed
        let operation = FakeOperation(runMode: mode)
        operation.addDelegate(delegate: self)
        runExpectation =  expectation(description: "operation with Value\(mode.runValue)")
        operation.start()
        
        wait(for: [runExpectation!], timeout: 1)
        XCTAssertEqual(self.runValue, RunMode.start.runValue + mode.runValue)
    }
    
    func testOperationDelegateCancelled() {
        let mode:RunMode = .cancelled
        let operation = FakeOperation(runMode: mode)
        operation.addDelegate(delegate: self)
        runExpectation =  expectation(description: "operation with Value\(mode.runValue)")
        operation.start()
        
        wait(for: [runExpectation!], timeout: 1)
        XCTAssertEqual(self.runValue, RunMode.start.runValue + mode.runValue)
    }
    
    func testOperationDelegateCanNotStart() {
        let mode:RunMode = .complete
        let operation = FakeOperation(runMode: mode)
        operation.addDelegate(delegate: self)
        operation.controlDelegate = self
        shouldStart = { _ in return false}
        runExpectation =  expectation(description: "operation with Value\(mode.runValue)")
        operation.start()
        
        wait(for: [runExpectation!], timeout: 1)
        XCTAssertEqual(self.runValue, RunMode.failed.runValue)
    }
    func testOperationDelegateShouldSkip() {
        let mode:RunMode = .failed
        let operation = FakeOperation(runMode: mode)
        operation.addDelegate(delegate: self)
        operation.controlDelegate = self
        shouldSkip = { _ in return true}
        runExpectation =  expectation(description: "operation with Value\(mode.runValue)")
        operation.start()
        
        wait(for: [runExpectation!], timeout: 1)
        XCTAssertEqual(self.runValue, RunMode.complete.runValue)
    }
    override func tearDown() {
        self.shouldStart = nil
        self.shouldSkip = nil
        self.runValue = 0
        self.runExpectation = nil
        
    }
    
}

