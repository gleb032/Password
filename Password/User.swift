import Foundation
import Tagged

struct User: Identifiable, Codable, Equatable {
  var id = UUID()
  var name: String
  var password: Tagged<Encrypted, String>
  var isBlocked = false
  var passwordRestriction = false
}

extension User {
  var isAdmin: Bool {
    name.lowercased() == "admin"
  }
}
