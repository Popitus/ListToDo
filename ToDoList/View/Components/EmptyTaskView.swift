import SwiftUI

struct EmptyTaskView: View {
    
    //Properties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var animationCount = 0
    @Binding var titleSelected: String
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "list.clipboard")
                .symbolEffect(.bounce, value: animationCount)
                .font(.system(size: 100))
                .onTapGesture {
                    animationCount += 1
                }
            if (titleSelected != "")  {
                Text("\(taskViewModel.checkPageSelected() != nil ? "\(String(localized:"empty_task_info")) \(titleSelected)" : String(localized:"title_select_category"))")
            }
            Spacer()
        }        
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    @State var title = "Prueba"
    return EmptyTaskView(titleSelected: $title)
        .environment(taskViewModel)
}
