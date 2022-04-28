//
//  DecisionTreeTableCreatorTests.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//
import XCTest

@testable import SUS

final class DecisionTreeTableCreatorTests: XCTestCase {
    let testingTable: String = """
        old,yes,swr,down
        old,no,swr,down
        old,no,hwr,down
        mid,yes,swr,down
        mid,yes,hwr,down
        mid,no,hwr,up
        mid,no,swr,up
        new,yes,swr,up
        new,no,hwr,up
        new,no,swr,up
        """
    var creator: DecisionTreeTableCreatorImpl?
    
    override func setUp() async throws {
        creator = DecisionTreeTableCreatorImpl(content: testingTable)
    }
    
    func testCreateDecisionsTreeTable() throws {
        let want: DecisionTreeTable = DecisionTreeTable(table: [
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
        
        let got = creator!.CreateDecisionsTreeTable()
        
        XCTAssertEqual(want, got)
    }
    
    func testDecisionTreeTableDecisionsArray() throws {
        let want: [String] = ["down","down","down","down","down", "up","up","up","up","up"]
        
        let got = creator!.CreateDecisionsTreeTable()
        
        XCTAssertEqual(want, got.decisions)
    }
    
    func testDecisionCount() throws {
        let want = 10.0
        
        let got = creator!.CreateDecisionsTreeTable()
        
        XCTAssertEqual(want, got.decisionsCount)
    }
    
    func testAttributes() throws {
        let want: [[String]] = [
            ["old", "yes", "swr"],
            ["old", "no", "swr"],
            ["old", "no", "hwr"],
            ["mid", "yes", "swr"],
            ["mid", "yes", "hwr"],
            ["mid", "no", "hwr"],
            ["mid", "no", "swr"],
            ["new", "yes", "swr"],
            ["new", "no", "hwr"],
            ["new", "no", "swr"]
        ]
        
        let got = creator!.CreateDecisionsTreeTable()
        
        XCTAssertEqual(want, got.attributes)
    }
    
    func testGetRowNumbersWithAttributeOld() throws {
        let got = creator!.CreateDecisionsTreeTable().getRowNumbersWithAttribute("old")
        let want = [0,1,2]
        
        XCTAssertEqual(got, want)
    }
    
    func testGetRowNumbersWithAttributeMid() throws {
        let got = creator!.CreateDecisionsTreeTable().getRowNumbersWithAttribute("mid")
        let want = [3,4,5,6]
        
        XCTAssertEqual(got, want)
    }
    
    func testGetRowNumbersWithAttributeNew() throws {
        let got = creator!.CreateDecisionsTreeTable().getRowNumbersWithAttribute("new")
        let want = [7,8,9]
        
        XCTAssertEqual(got, want)
    }
    
    func testGetDecisionsMap() throws {
        let got = creator!.CreateDecisionsTreeTable().getDecisionsMapForAttribute("mid")
        let want: AttributesCountMap = ["down": 2, "up" : 2]
        
        XCTAssertEqual(got, want)
    }
    
    func testCountAttributes() throws {
        let creator = DecisionTreeTableCreatorImpl(content: testingTable)
            
        let wantAttributes: [AttributesCountMap] = [["new": 3, "old": 3, "mid": 4], ["no": 6, "yes": 4], ["hwr": 4, "swr": 6], ["down": 5, "up": 5]]
        let attributes = try creator.CountAttributes()
        
        XCTAssertEqual(wantAttributes, attributes)
    }
}

