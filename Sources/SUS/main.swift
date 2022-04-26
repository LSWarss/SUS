import ArgumentParser

struct SUS: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool for handling decision trees",
        subcommands: [Attributes.self])
    
    init() {}
}

SUS.main()
