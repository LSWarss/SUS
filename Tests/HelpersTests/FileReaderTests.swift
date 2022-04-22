import XCTest

@testable import SUS

final class FileReaderTests: XCTestCase {
    
    let mockFileManager: MockFileManager = MockFileManager()

    func testLocalFileReader() throws {
        mockFileManager.mockContent = "This is test"
        let reader = LocalFileReader(fileManager: mockFileManager)
        try XCTAssertEqual(reader.readFile(inputFilePath: "TestingReaderFile.txt"), "This is test")
    }
}
