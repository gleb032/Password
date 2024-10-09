import Tagged

enum Encrypted {}

protocol Encryption {
  func encrypt(_ text: String) -> Tagged<Encrypted, String>
}
