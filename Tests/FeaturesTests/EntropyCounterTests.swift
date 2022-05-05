//
//  EntropyCounterTests.swift
//  FeaturesTests
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import XCTest

@testable import SUS

class EntropyCounterTests: XCTestCase {

    let testTable: DecisionTreeTable = DecisionTreeTable(table: [
        ["old", "yes", "swr", "down"],
        ["old", "no", "swr", "down"],
        ["old", "no", "hwr", "down"],
        ["mid", "yes", "swr", "down"],
        ["mid", "yes", "hwr", "down"],
        ["mid", "no", "hwr", "up"],
        ["mid", "no", "swr", "up"],
        ["new", "yes", "swr", "up"],
        ["new", "no", "hwr", "up"],
        ["new", "no", "swr", "up"]
    ])
    
    let testTable2: DecisionTreeTable = DecisionTreeTable(table: [
        ["old", "yes", "swr", "down"],
        ["old", "no", "swr", "front"],
        ["old", "no", "hwr", "down"],
        ["mid", "yes", "swr", "down"],
        ["mid", "yes", "hwr", "front"],
        ["mid", "no", "hwr", "up"],
        ["mid", "no", "swr", "up"],
        ["new", "yes", "swr", "up"],
        ["new", "no", "hwr", "up"],
    ])
    
    let failAttributes: [AttributesCountMap] = []
    let entopyCounter = EntropyCounterImpl()
    
    func testCalculateEntropy() throws {
        var got = entopyCounter.CalculateEntropy(of: testTable)
        var want = 1.0
        XCTAssertEqual(got, want)
        
        got = entopyCounter.CalculateEntropy(of: testTable2)
        want = 1.5304930567574826
        XCTAssertEqual(got, want)
    }

    func testCalculateEntropyForAttribute() throws {
        var got = entopyCounter.CalculateEntropyForAttribute("mid", in: testTable)
        var want = 1.0
        XCTAssertEqual(got, want, "Value of entropy for 'mid' should be 1.0")
        
        got = entopyCounter.CalculateEntropyForAttribute("old", in: testTable)
        want = 0.0
        XCTAssertEqual(got, want, "Value of entropy for 'old' should be 0.0")
        
        got = entopyCounter.CalculateEntropyForAttribute("new", in: testTable)
        want = 0.0
        XCTAssertEqual(got, want, "Value of entropy for 'new' should be 0.0")
        
        got = entopyCounter.CalculateEntropyForAttribute("new", in: testTable2)
        want = 0.0
        XCTAssertEqual(got, want, "Value of entropy for 'new' should be 0.0")
        
        got = entopyCounter.CalculateEntropyForAttribute("mid", in: testTable2)
        want = 1.5
        XCTAssertEqual(got, want, "Value of entropy for 'mid' should be 0.0")
        
        got = entopyCounter.CalculateEntropyForAttribute("old", in: testTable2)
        want = 0.9182958340544896
        XCTAssertEqual(got, want, "Value of entropy for 'new' should be 0.0")
    }
}
