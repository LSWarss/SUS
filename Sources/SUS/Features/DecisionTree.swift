//
//  DecisionTreeCreator.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import Foundation

protocol DecisionTreeCreator {
    func CountAttributes() throws -> [AttributesMap]
}

final class DecisionTreeCreatorImpl: DecisionTreeCreator {
    
    private let content: String
    
    init(content: String) {
        self.content = content
    }
    
    func CountAttributes() throws -> [AttributesMap] {
        return createAttributesMapArray()
    }
}

private extension DecisionTreeCreatorImpl {
    
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
