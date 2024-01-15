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
                
                HStack {
                    TextField("Nueva Tarea", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        taskViewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }, label: {
                        Text("Agregar")
                    })
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
