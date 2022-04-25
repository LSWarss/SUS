import Foundation

protocol FileReader {
    func readFile(inputFilePath: String) throws -> String
}

enum FileReaderError: Error {
    case fileNotFound(name: String)
    case fileReadError
}

struct LocalFileReader: FileReader {
    
    let fileManager: FileManager
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }

    func readFile(inputFilePath: String) throws -> String {
        guard let data = fileManager.contents(atPath: inputFilePath) else {
            throw FileReaderError.fileNotFound(name: inputFilePath)
        }
        
        guard let savedData = String(data: data, encoding: .utf8) else {
            throw FileReaderError.fileReadError
        }
        
        return savedData
    }
}
