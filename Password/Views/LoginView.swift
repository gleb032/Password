import SwiftUI

struct LoginView: View {
  @EnvironmentObject var userManager: UserManager
  @State private var name = ""
  @State private var password = ""
  @State private var error: AuthenticationError? = nil

  var body: some View {
    VStack {
      TextField("Username", text: $name)
        .textFieldStyle(.roundedBorder)
        .padding()
      SecureField("Password", text: $password)
        .textFieldStyle(.roundedBorder)
        .padding()
      if let error {
        Text(error.text)
          .foregroundColor(.red)
        Text("Attempts left: \(3 - userManager.passwordAttempts)")
      }
      Button("Login") {
        if let error = userManager.authenticateUser(name: name, password: password) {
          if userManager.passwordAttempts >= 3 {
            exit(0)
          }
          self.error = error
        } else {
          error = nil
        }
      }
      .padding()
    }
    .navigationTitle("Login")
    .padding()
  }
}

extension AuthenticationError {
  fileprivate var text: String {
    switch self {
    case .invalidUsername:
      "Invalid username!"
    case .invalidPassword:
      "Invalid password!"
    }
  }
}
