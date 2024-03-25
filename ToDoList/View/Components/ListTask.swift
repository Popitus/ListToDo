
import SwiftUI

struct ListTask: View {
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State var item: TasksLocal?
    
    var body: some View {
        
        if let item = item {
        #if DEBUG
            NavigationLink(
                destination: DetailTaskView(
                    task: item,
                    localTags: taskViewModel.tags.filter{$0.taskItemID == item.id})) {
                        TaskItemRow(task: item)
                    }
        #else
            if (item.completed != true) {
                NavigationLink(
                    destination: DetailTaskView(
                        task: item,
                        localTags: taskViewModel.tags.filter{$0.taskItemID == item.id})) {
                            TaskItemRow(task: item)
                        }
            }
        #endif
        }
        
        
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    
    return ListTask(item: TasksLocal(title: "Titulo 1", date: .now, status: .completed, note: "Nota completa", lastUpdate: .now))
        .environment(taskViewModel)
}
