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
        let localWriter = LocalFileWriter()
        let content = try localReader.readFile(inputFilePath: path)
        let creator = DecisionTreeAttributesCreatorImpl(content: content)
        let attributes = try creator.CountAttributes().description
        
        SUSLogger.shared.info("\(attributes)")
        try localWriter.writeToFile(fileName: "\(path.fileName())_Attributes.\(path.fileExtension())", content: attributes.data(using: .utf8))
    }
}
