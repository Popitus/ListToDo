
import SwiftUI

struct ListTask: View {
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State var item: TaskItem
    
    var body: some View {
    
            #if DEBUG
            NavigationLink(
                destination: DetailTaskView(
                    task: item,
                    localTags: taskViewModel.tags.filter{$0.taskItem?.id == item.id})) {
                        TaskItemRow(task: item)
                            .onTapGesture{
                                withAnimation {
                                    taskViewModel.toggleTaskCompletion(task: item)
                                }
                            }
                    }
            #else
            if (item.completed != true) {
                NavigationLink(
                    destination: DetailTaskView(
                        task: item,
                        localTags: taskViewModel.tags.filter{$0.taskItem?.id == item.id})) {
                            TaskItemRow(task: item)
                                .onTapGesture{
                                    withAnimation {
                                        taskViewModel.toggleTaskCompletion(task: item)
                                    }
                                }
                        }
            }
            #endif

    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    
    return ListTask(item: TaskItem(title: "Titulo 1", date: .now, status: .completed, note: "Nota completa", lastUpdate: .now))
        .environment(taskViewModel)
}
