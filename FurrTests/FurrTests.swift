//
//  FurrTests.swift
//  FurrTests
//
//  Created by Mitch on 24/02/2020.
//  Copyright © 2020 Mitch. All rights reserved.
//

import XCTest
@testable import Furr

class FurrTests: XCTestCase {
    var testString = ""
    var stringArray = [String]()
    
    override func setUp() {
        testString = "<meta property= og:description content = What is Bao Box? Bao Box is a result of passion, we are 6 individuals who have come"
    }
    
    override func tearDown() {
        testString = ""
        stringArray.removeAll()
    }
    
    func testHundredth(){
        Server().getHundredth(index: 0, string: testString, offset: 10, completion: {string,int,error in
            XCTAssertEqual(string, "p")
        })
    }
    
    func testCount(){
        Server().getCount(index: 0, string: testString, completion: {string,int,error in
            guard let string = string else{
                XCTFail()
                return
            }
            self.stringArray.append(string)
        })
        print("count \(stringArray.count)")
        XCTAssertEqual(stringArray.count, 23)
    }
    
    func testEvery(){
        Server().getEvery(index: 0, string: testString, separation: 40, completion: {string,int,error in
            guard let string = string else{
                XCTFail()
                return
            }
            self.stringArray.append(string)
            
        })
        let array = ["=", "f", " ", "e"]
        XCTAssertEqual(self.stringArray, array)
    }
}
