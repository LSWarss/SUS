import XCTest

@testable import SUS

final class FileReaderTests: XCTestCase { 

    func testLocalFileReader() throws {
        let reader = LocalFileReader()
        let bundle = Bundle(for: Self.self)
        try XCTAssertEqual(reader.readFile(inputFilePath: "TestingReaderFile.txt", in: bundle), "This is test")
    }

}
