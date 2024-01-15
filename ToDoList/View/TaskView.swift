import SwiftUI

struct TaskView: View {
    
    @StateObject private var taskViewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskViewModel.tasks) { task in
                        TaskItemRow(task: task) {
                            taskViewModel.toggleTaskCompletion(task: task)
                        }
                    }
                    .onDelete(perform: taskViewModel.removeTask)
                }
                AddTaskView(newTaskTitle: $newTaskTitle) {
                    if !newTaskTitle.isEmpty {
                        taskViewModel.addTask(title: newTaskTitle)
                    }
                }
                .padding()
            }
            .navigationTitle("Lista de Tareas")
        }
    }
}

#Preview {
    TaskView()
}
