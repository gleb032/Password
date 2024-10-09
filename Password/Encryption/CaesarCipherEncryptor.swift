import Foundation
import Tagged

struct СaesarCipherEncryptor: Encryption {
  private let shift: Int
  private let letters = Array("abcdefghijklmnopqrstuvwxyz")
  private let upperLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

  init(shift: Int = 3) {
    self.shift = shift
  }

  func encrypt(_ text: String) -> Tagged<Encrypted, String> {
    var encrypted = ""

    for char in text {
      if let index = letters.firstIndex(of: char) {
        let newIndex = (index + shift) % letters.count
        encrypted.append(letters[newIndex])
      } else if let index = upperLetters.firstIndex(of: char) {
        let newIndex = (index + shift) % upperLetters.count
        encrypted.append(upperLetters[newIndex])
      } else {
        encrypted.append(char)
      }
    }

    return Tagged<Encrypted, String>(encrypted)
  }
}
