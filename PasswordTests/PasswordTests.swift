import XCTest
@testable import Password

final class EncryptorTest: XCTestCase {
  private let encryptor: Encryptor = .caesarAndGammaCombinedEncryptor

  func testExample() throws {
    XCTAssertEqual(encryptor.encrypt("12345").rawValue, "+Sfgs+Q=")
  }
}
