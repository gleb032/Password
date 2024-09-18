import SwiftUI

struct EditUserView: View {
  @EnvironmentObject var userManager: UserManager
  @Environment(\.dismiss) private var dismiss
  var user: User

  var body: some View {
    Form {
      Section(header: Text("User Actions")) {
        Toggle("Block User", isOn: $userManager.users[userManager.users.firstIndex { $0.id == user.id }!].isBlocked)
        Toggle("Password Restriction", isOn: $userManager.users[userManager.users.firstIndex { $0.id == user.id }!].passwordRestriction)
        Button("Delete User") {
          if let index = userManager.users.firstIndex(where: { $0.id == user.id }) {
            userManager.users.remove(at: index)
            userManager.saveUsers()
            dismiss()
          }
        }
        .foregroundColor(.red)
      }
    }
    .navigationTitle(user.name)
  }
}
