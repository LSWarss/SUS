//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import Foundation

protocol DecisionTreeTableCreator {
    func CountAttributes() throws -> [AttributesMap]
}

typealias AttributesMap = [String: Int]

class DecisionTreeTableCreatorImpl: DecisionTreeTableCreator {
    
    private let fileWriter: FileWriter
    private let content: String
    
    init(fileWriter: FileWriter, content: String) {
        self.fileWriter = fileWriter
        self.content = content
    }
    
    func CountAttributes() throws -> [AttributesMap] {
        return createAttributesMapArray()
    }
}

private extension DecisionTreeTableCreatorImpl {
    
    func createAttributesMapArray() -> [AttributesMap] {
        var attributes: [AttributesMap] = []
        content.enumerateLines { line, stop in
            let temp = line.split(separator: ",")
            
            for (i, str) in temp.enumerated() {
                if attributes.count <= i {
                    attributes.append([String(str): 1])
                } else {
                    if let number = attributes[i][String(str)] {
                        attributes[i][String(str)] = number + 1
                    } else {
                        attributes[i][String(str)] = 1
                    }
                }
            }
        }
        
        return attributes
    }
}
