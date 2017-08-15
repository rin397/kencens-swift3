//
//  timerTests.swift
//  timerTests
//
//  Created by Wilson Hsieh on 2017/8/7.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import XCTest
@testable import timer

class timerTests: XCTestCase {
    
    var i = 0
    
    override func setUp() {
        print("it's set up start")
        
        super.setUp()
        
        print("it's set up start")
        
    }
    
    override func tearDown() {
       
        print("it's tear Down start")
        super.tearDown()
        print("it's tear Down end")
        
    }
    
    func testFunction() {
        
        print("it's testFunction start")
        
        XCTAssertEqual(1, 1)
       
        print("it's testFunction end")
        
    }
    
  
    
    func testPerformanceExample() {
        
        self.measure {
           
        }
    }
    
}
