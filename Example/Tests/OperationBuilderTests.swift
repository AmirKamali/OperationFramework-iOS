//
//  OperationBuilderTests.swift
//  OperationFrameworkTests
//
//  Created by Amir on 7/2/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import XCTest
import OperationFramework
class OperationBuilderTests: XCTestCase,ChainedOperationControlDelegate,ChainedOperationDelegate {
    var builder:FakeOperationBuilder?
    
    var canStart: ((ChainedOperation) -> Bool)?
    
    var shouldSkip: ((ChainedOperation) -> Bool)?
    
    func onBuilderRunComplete(operation: ChainedOperation) {
        
    }
    
    var runExpectation:XCTestExpectation?
    
    func onOperationStart(operation: ChainedOperation) {
        
    }
    
    func onOperationComplete(operation: ChainedOperation) {
        print("Completed :\(operation.id)")
        if operation == builder?.operations.last {
            runExpectation?.fulfill()
        }
    }
    
    func onOperationFailed(operation: ChainedOperation, error: Error) {
        
    }
    
    func onOperationCancelled(operation: ChainedOperation) {
        
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOperationBuilder_simple_chained_operations() {
        builder = FakeOperationBuilder(delegate: self)
        runExpectation =  expectation(description: "operation builder")
        builder?.start()
        wait(for: [runExpectation!], timeout: 5)
        XCTAssertEqual(builder?.dataModel.overalValue, 5 * RunMode.complete.runValue)
    }
    
    func testOperationBuilder_chained_builders_operations() {
        builder = FakeOperationBuilder(delegate: self)
        print("Original ID:\(builder?.id ?? "-")")
        let childBuilder = FakeOperationBuilder(delegate:nil)
        print("B2 ID:\(childBuilder.id)")
        childBuilder.id = "Builder2"
        builder?.addOperation(operation: childBuilder)
        runExpectation =  expectation(description: "operation builder")
        builder?.start()
        wait(for: [runExpectation!], timeout: 500)
        XCTAssertEqual(builder?.dataModel.overalValue, 10 * RunMode.complete.runValue)
    }
    
    func testOperationBuilder_insert_chained_builders_operations() {
        builder = FakeOperationBuilder(delegate: self)
        print("Original ID:\(builder?.id ?? "-")")
        let B2 = FakeOperationBuilder(delegate:nil)
        print("B2 ID:\(B2.id)")
        builder?.insertOperation(atIndex: 3, operation: B2)
        runExpectation =  expectation(description: "operation builder")
        builder?.start()
        wait(for: [runExpectation!], timeout: 5)
        XCTAssertEqual(builder?.dataModel.overalValue, 10 * RunMode.complete.runValue)
    }
}
