//
//  DecisionTreeTableCreatorTests.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//
import XCTest

@testable import SUS

final class DecisionTreeTableCreatorTests: XCTestCase {
    
    let mockFileManager: MockFileManager = MockFileManager()
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
    
    
}

