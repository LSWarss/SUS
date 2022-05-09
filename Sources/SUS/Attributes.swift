//
//  Attributes.swift
//
//  Created by Łukasz Stachnik on 21/04/2022.
//

import ArgumentParser
import Foundation

struct Attributes: ParsableCommand {
 
    //Argument: A required argument that is needed for this subcommand.
    //Option: An optional argument that can be used as input.
    //Flag: Extra options that impact the execution
    
    public static let configuration = CommandConfiguration(abstract: "Decision Tree Table Arguments CLI")
    
    @Argument(help: "Path to the file with decision table")
    private var path: String
    
    func run() throws {
        let localReader = LocalFileReader()
        let treeCreator = DecisionTreeCreator(entropyCounter: EntropyCounterImpl())
        
        let content = try localReader.readFile(inputFilePath: path)
        let creator = DecisionTreeTableCreatorImpl()
        let treeTable = try creator.CreateDecisionsTreeTable(from: content)
        let tree = try treeCreator.CreateDecisionTree(from: treeTable)
        
        treeCreator.Traverse(tree: tree)
    }
}
