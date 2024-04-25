
import SwiftUI

struct ListTask: View {
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel

    var item: TasksLocal

    var body: some View {
       
            #if DEBUG
                NavigationLink(
                    destination: DetailTaskView(
                        task: item,
                        localTags: taskViewModel.tags.filter { $0.taskItemID == item.id }
                    )) {
                        TaskItemRow(task: item)
                    }
            #else
                if item.completed != true {
                    NavigationLink(
                        destination: DetailTaskView(
                            task: item,
                            localTags: taskViewModel.tags.filter { $0.taskItemID == item.id }
                        )) {
                            TaskItemRow(task: item)
                        }
                }
            #endif
        
    }
}

#Preview {
    ListTask(item: .sample)
        .environment(TaskViewModel.preview)
}
