import Foundation

protocol FileReader {
    func readFile(inputFilePath: String, in bundle: Bundle) throws -> String
}

enum FileReaderError: Error {
    case fileNotFound(name: String)
}

struct LocalFileReader: FileReader { 

    func readFile(inputFilePath: String, in bundle: Bundle = .main) throws -> String {
        let fileExtension = inputFilePath.fileExtension()
        let fileName = inputFilePath.fileName()
        
        print(bundle.bundleURL)
        
        guard let fileURL = bundle.url(
            forResource: fileName,
            withExtension: fileExtension) else {
            throw FileReaderError.fileNotFound(name: fileName)
        }
        
        do {
            let savedData = try String(contentsOf: fileURL)
            return savedData
        } catch {
            throw error
        }
    }
}
