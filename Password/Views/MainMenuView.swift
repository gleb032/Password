import SwiftUI

struct MainMenuView: View {
  @EnvironmentObject var userManager: UserManager

  var body: some View {
    List {
      Section(header: Text("Actions")) {
        NavigationLink("Change Password", destination: ChangePasswordView().environmentObject(userManager))
        if userManager.loggedUser?.isAdmin == true {
          NavigationLink("Manage Users", destination: ManageUsersView().environmentObject(userManager))
        }
        Button("Logout") {
          userManager.loggedUser = nil
        }
      }
      Section(header: Text("Help")) {
        NavigationLink("About", destination: AboutView())
      }
    }
    .navigationTitle("Main Menu")
  }
}
