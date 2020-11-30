import XCTest
import DataStream
import CompoundFileReader
@testable import OfficeFormReader

final class UserFormTests: XCTestCase {
    func testExample() throws {
        do {
            let data = try getData(name: "hughbe/VBA File", fileExtension: "doc")
            let parentFile = try CompoundFile(data: data)
            var rootStorage = parentFile.rootStorage
            var macros = rootStorage.children["Macros"]!
            let file = try UserForm(storage: macros.children["UserForm1"]!)
            XCTAssertEqual(15, file.formControl.siteData.sites.count)
            XCTAssertEqual("Label1", file.formControl.siteData.sites[0].extraDataBlock.name?.value)
            XCTAssertEqual("Tag", file.formControl.siteData.sites[0].extraDataBlock.tag?.value)
            XCTAssertEqual("TextBox1", file.formControl.siteData.sites[1].extraDataBlock.name?.value)
            XCTAssertNil(file.formControl.siteData.sites[1].extraDataBlock.tag?.value)
            XCTAssertEqual("CommandButton1", file.formControl.siteData.sites[2].extraDataBlock.name?.value)
            XCTAssertNil(file.formControl.siteData.sites[2].extraDataBlock.tag?.value)
            
            XCTAssertEqual(15, file.objectData.embeddedControls.count)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
