import SwiftUI
import SwiftData

struct TaskView: View {
    
    //Properties
    @State private var taskViewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var titleSelected = "Tarea"
    
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    ForEach(taskViewModel.tasks) { task in
                        TaskItemRow(task: task)
                            .onTapGesture {
                                withAnimation {
                                    taskViewModel.toggleTaskCompletion(task: task)
                                }
                            }
                    }
                    .onDelete(perform: taskViewModel.removeTask)
                }
                
                HorizontalPages(
                    pages: taskViewModel.pages,
                    toggleCompletionAddPage: {
                        alertTextField(
                            title: "Añadir nueva pagina",
                            message: "Esto es una prueba del mensaje",
                            hintText: "añadir aqui gañan",
                            primaryTitle: "Añadir",
                            secondaryTitle: "Cancelar",
                            primaryAction: { text in
                                if !text.isEmpty {
                                    taskViewModel.addTaskPage(title: text)
                                }
                            },
                            secondaryAction: {
                                print("Cancelado")
                            })
                    },
                    toggleSelectedPage:  { titlePage in
                        titleSelected = titlePage
                    },
                    toggleDeletedPage: { idPage in taskViewModel.removePages(with: idPage)})
                .padding()
                
                AddTaskView(newTaskTitle: $newTaskTitle) {
                    if !newTaskTitle.isEmpty {
                        taskViewModel.addTask(title: newTaskTitle)
                    }
                }
                .padding()
            }
            .navigationTitle("\(titleSelected) Seleccionada")
        }
    }
}

#Preview {
    let preview = PreviewSwiftdata([TaskItem.self])
    return TaskView()
        .modelContainer(preview.container)
}
