import SwiftUI

struct ContentView: View {
  @StateObject var userManager = UserManager()
  
  var body: some View {
    NavigationView {
      if userManager.loggedUser == nil {
        LoginView()
          .environmentObject(userManager)
      } else {
        MainMenuView()
          .environmentObject(userManager)
      }
    }
  }
}
