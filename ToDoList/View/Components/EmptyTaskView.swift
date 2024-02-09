import SwiftUI

struct EmptyTaskView: View {
    @State private var animationCount = 0
    @Binding var titleSelected: String
    @State var checkPagedSelected: TaskPageItem?
    
    var body: some View {
        Spacer()
        Image(systemName: "list.clipboard")
            .symbolEffect(.bounce, value: animationCount)
            .font(.system(size: 100))
            .onTapGesture {
                animationCount += 1
            }
        if (titleSelected != "") && (checkPagedSelected != nil) {
            Text("Sin tareas en \(titleSelected)")
        }
        Spacer()
    }
}

#Preview {
    @State var title = "Prueba"
    return EmptyTaskView(titleSelected: $title, checkPagedSelected: TaskPageItem(title: "Titulo de Lista") ?? nil)
}
