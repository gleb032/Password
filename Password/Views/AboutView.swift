import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("**Информация о программе**")
        .font(.largeTitle)
        .padding()

      Text("**Автор:** Глеб Фандеев")
        .padding(3)
      Text("**Группа:** А-18-21")
        .padding(3)
      Text("**Лабораторная №1:** Разработка программы  разграничения полномочий пользователей на основе парольной аутентификации")
        .padding(3)
      Text("**Индивидуальный вариант** (ограничения на выбираемые пароли): 19.  Отсутствие повторяющихся символов.")
        .padding(3)
      Spacer()
    }
    .padding()
  }
}

