import SwiftUI

struct TitleSection: View {
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State var title: String = ""
    @State var conditional: Bool = false
    @Binding var showActive: Bool
    @Binding var idTaskFromPage: UUID
    
    var body: some View {
        HStack {
            Text("\(title)\(taskViewModel.checkActivetask(is: conditional, id: idTaskFromPage) > 0 ? " - \(taskViewModel.checkActivetask(is: conditional, id: idTaskFromPage))" : "")")
                .font(.headline)
            Spacer()
            Image(systemName: showActive ? "chevron.down" : "chevron.right")
        }
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    @State var showActive = true
    @State var idTaskFromPage = UUID()
    return TitleSection(showActive: $showActive, idTaskFromPage: $idTaskFromPage)
        .environment(taskViewModel)
}
