import SwiftUI

struct ChangePasswordView: View {
  @EnvironmentObject var userManager: UserManager
  @State private var oldPassword = ""
  @State private var newPassword = ""
  @State private var confirmPassword = ""
  @State private var state: Result<Void, ChangePasswordError>? = nil

  var body: some View {
    Form {
      Section(header: Text("Change Password")) {
        SecureField("Old Password", text: $oldPassword)
        SecureField("New Password", text: $newPassword)
        SecureField("Confirm Password", text: $confirmPassword)
        if let state {
          switch state {
          case .success:
            Text("Password changed")
              .foregroundColor(.green)
          case let .failure(error):
            Text(error.text)
              .foregroundColor(.red)
          }
        }
        Button("Change Password") {
          guard let loggedUser = userManager.loggedUser else {
            assertionFailure()
            return
          }
          
          guard userManager.checkPassword(input: oldPassword) else {
            state = .failure(.oldPasswordIncorrect)
            return
          }

          guard newPassword == confirmPassword else {
            state = .failure(.passwordsDontMatch)
            return
          }

          guard userManager.isPasswordValid(newPassword, restriction: loggedUser.passwordRestriction) else {
            state = .failure(.passwordNotValid)
            return
          }

          userManager.changePassword(for: loggedUser, newPassword: newPassword)
          state = .success(())
          resetFields()
        }
      }
    }
    .navigationTitle("Change Password")
  }

  private func resetFields() {
    oldPassword = ""
    newPassword = ""
    confirmPassword = ""
  }
}

private enum ChangePasswordError {
  case oldPasswordIncorrect
  case passwordsDontMatch
  case passwordNotValid
}

extension ChangePasswordError: Error {
  fileprivate var text: String {
    switch self {
    case .oldPasswordIncorrect:
      "Old password is incorrect"
    case .passwordsDontMatch:
      "Passwords do not Match"
    case .passwordNotValid:
      "New password does not meet restrictions"
    }
  }
}
