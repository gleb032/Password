import SwiftUI

struct ManageUsersView: View {
  @EnvironmentObject var userManager: UserManager
  @State private var newUserName = ""
  @State private var showDuplicateError = false

  var body: some View {
    VStack {
      List {
        ForEach(userManager.users) { user in
          NavigationLink(user.name) {
            EditUserView(user: user)
              .environmentObject(userManager)
          }
        }
        Section(header: Text("Add New User")) {
          TextField("Username", text: $newUserName)
          if showDuplicateError {
            Text("User already exists.")
              .foregroundColor(.red)
          }
          Button("Add User") {
            if userManager.findUser(name: newUserName) == nil {
              userManager.addUser(name: newUserName)
              showDuplicateError = false
              newUserName = ""
            } else {
              showDuplicateError = true
            }
          }
        }
      }
      .navigationTitle("Manage Users")
    }
  }
}

