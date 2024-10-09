import Foundation
import Tagged

class Encryptor: Encryption {
  private let encryptors: [Encryption]

  init(encryptors: [Encryption]) {
    self.encryptors = encryptors
  }

  func encrypt(_ text: String) -> Tagged<Encrypted, String> {
    var encripted = text
    encryptors.forEach { encryptor in
      encripted = encryptor.encrypt(encripted).rawValue
    }
    return Tagged<Encrypted, String>(encripted)
  }
}

extension Encryptor {
  static let caesarAndGammaCombinedEncryptor = Encryptor(
    encryptors: [СaesarCipherEncryptor(), GammaEncryptor()]
  )
}
