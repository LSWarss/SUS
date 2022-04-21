//
//  Hello.swift
//
//  Created by Łukasz Stachnik on 21/04/2022.
//

import ArgumentParser

struct Hello: ParsableCommand {
 
    //Argument: A required argument that is needed for this subcommand.
    //Option: An optional argument that can be used as input.
    //Flag: Extra options that impact the execution
    
    public static let configuration = CommandConfiguration(abstract: "Hello message CLI")
    
    @Argument(help: "Name of the person to which the hello goes to")
    private var name: String
        
    func run() throws {
        print("Hello \(name)!")
    }
}
