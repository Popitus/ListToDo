import SwiftUI
import SwiftData

struct TaskView: View {
    
    //Properties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var newTaskTitle = String()
    @State private var titleSelected = "Tarea"
    @State private var idTaskFromPage = UUID()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskViewModel.tasks) { item in
                        if item.taskPageItem?.id == idTaskFromPage {
                            NavigationLink(destination: DetailTaskView(
                                task: item,
                                localTags: taskViewModel.tags.filter{$0.taskItem?.id == item.id})) {
                                    TaskItemRow(
                                        task: item)
                                    .onTapGesture{
                                        withAnimation {
                                            taskViewModel.toggleTaskCompletion(task: item)
                                        }
                                    }
                                }
                        }
                    }
                    .onDelete(perform: taskViewModel.removeTask)
                    
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
                        
                        if page.selected {
                            idTaskFromPage = page.id
                            titleSelected = page.title
                        } else {
                            idTaskFromPage = UUID()
                            titleSelected = String()
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
            
            .onAppear {
                idTaskFromPage = taskViewModel.checkPageSelected()
            }
        }
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    return TaskView()
        .environment(taskViewModel)
}
