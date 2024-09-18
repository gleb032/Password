import Foundation
import Combine

struct User: Identifiable, Codable, Equatable {
  var id = UUID()
  var name: String
  var password: String
  var isBlocked = false
  var passwordRestriction = false
}

extension User {
  var isAdmin: Bool {
    name.lowercased() == "admin"
  }
}
