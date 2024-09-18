import SwiftUI

class UserManager: ObservableObject {
  @Published var users: [User] = [User(name: "ADMIN", password: "")]
  @Published var loggedUser: User?
  @Published var passwordAttempts = 0

  private let userFile = "users.json"

  init() {
    loadUsers()
  }

  func loadUsers() {
    if let data = try? Data(contentsOf: getFilePath()) {
      if let decoded = try? JSONDecoder().decode([User].self, from: data) {
        users = decoded
        return
      }
    }
  }

  func saveUsers() {
    if let encoded = try? JSONEncoder().encode(users) {
      try? encoded.write(to: getFilePath())
    }
  }

  func getFilePath() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0].appendingPathComponent(userFile)
  }

  func addUser(name: String) {
    if !users.contains(where: { $0.name.lowercased() == name.lowercased() }) {
      users.append(User(name: name, password: ""))
      saveUsers()
    }
  }

  func findUser(name: String) -> User? {
    return users.first(where: { $0.name.lowercased() == name.lowercased() })
  }

  func authenticateUser(name: String, password: String) -> AuthenticationError? {
    guard let user = findUser(name: name) else {
      passwordAttempts += 1
      return .invalidUsername
    }

    if user.password == password {
      passwordAttempts = 0
      loggedUser = user
      return nil
    }

    passwordAttempts += 1
    return .invalidPassword
  }

  func isPasswordValid(_ password: String, restriction: Bool) -> Bool {
    if restriction {
      let characterSet = Set(password)
      return characterSet.count == password.count
    }
    return true
  }

  func changePassword(for user: User, newPassword: String) {
    if let index = users.firstIndex(where: { $0.id == user.id }) {
      users[index].password = newPassword
      loggedUser?.password = newPassword
      saveUsers()
    }
  }

  func blockUser(_ user: User) {
    if let index = users.firstIndex(where: { $0.id == user.id }) {
      users[index].isBlocked = true
      saveUsers()
    }
  }

  func togglePasswordRestriction(for user: User) {
    if let index = users.firstIndex(where: { $0.id == user.id }) {
      users[index].passwordRestriction.toggle()
      saveUsers()
    }
  }
}

enum AuthenticationError {
  case invalidUsername
  case invalidPassword
}
