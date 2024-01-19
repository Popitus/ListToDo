import SwiftUI
import SwiftData

struct TaskView: View {
    
    //Properties
    @State private var taskViewModel = TaskViewModel()
    @State private var newTaskTitle = String()
    @State private var titleSelected = "Tarea"
    @State private var idTaskFromPage = UUID()
    
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    
                    ForEach(taskViewModel.pages) { tasks in
                        if tasks.id == idTaskFromPage {
                            ForEach(tasks.tasksItems ?? []) { task in
                                TaskItemRow(task: task)
                                    .onTapGesture {
                                        withAnimation {
                                            taskViewModel.toggleTaskCompletion(task: task)
                                        }
                                    }
                            }
                            .onDelete(perform: taskViewModel.removeTask)
                        }
                       
                    }
                    
                }
                
                HorizontalPages(
                    pages: taskViewModel.pages,
                    toggleCompletionAddPage: {
                        alertTextField(
                            title: "Añadir nueva categoría",
                            message: "Crea una nueva categoria para tus tareas",
                            hintText: "Titulo de categoría",
                            primaryTitle: "Añadir",
                            secondaryTitle: "Descartar",
                            primaryAction: { text in
                                if !text.isEmpty {
                                    taskViewModel.addTaskPage(title: text)
                                }
                            },
                            secondaryAction: {})
                    },
                    toggleSelectedPage:  { page in
                        taskViewModel.togglePageSelection(page: page)
                        titleSelected = page.selected ? page.title : ""
                        if page.selected {
                            idTaskFromPage = page.id
                        } else {
                            idTaskFromPage = UUID()
                        }
                    },
                    toggleDeletedPage: { idPage in
                        withAnimation {
                            taskViewModel.removePages(with: idPage)
                            titleSelected = String()
                        }
                    })
                .padding()
                
                AddTaskView(newTaskTitle: $newTaskTitle) {
                    if !newTaskTitle.isEmpty {
                        taskViewModel.addTask(title: newTaskTitle, idTaskPage: idTaskFromPage)
                    }
                }
                .padding()
            }
            .navigationTitle(titleSelected.isEmpty ? "Seleccionar Tarea" :"\(titleSelected)" )
        }
    }
}

#Preview {
    let preview = PreviewSwiftdata([TaskItem.self])
    return TaskView()
        .modelContainer(preview.container)
}
