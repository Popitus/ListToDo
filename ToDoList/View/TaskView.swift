import SwiftUI
import SwiftData

struct TaskView: View {
    
    //Properties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var newTaskTitle = String()
    @State private var titleSelected = ""
    @State private var idTaskFromPage = UUID()
    @State private var showActive = true
    @State private var showInactive = true
    @State private var animationCount = 0
    
    var body: some View {
        @Bindable var taskvmBindable = taskViewModel //<- @Environment object aren’t directly bindable
        NavigationView {
            VStack {
                if taskViewModel.pages.isEmpty {
                    Spacer()
                    Image(systemName: "book.pages.fill")
                        .symbolEffect(.bounce, value: animationCount)
                        .font(.system(size: 100))
                        .onTapGesture {
                            animationCount += 1
                        }
                    Text("Sin páginas")
                    Spacer()
                } else {
                    if !taskViewModel.tasks.isEmpty {
                        List {
                            Section {
                                if showActive {
                                    ForEach(taskViewModel.taskSearch) { item in
                                        if (item.taskPageItem?.id == idTaskFromPage) && (item.completed != true) {
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
                                    }
                                    .onDelete(perform: taskViewModel.removeTask)
                                }
                                
                            } header: {
                                if !taskViewModel.tasks.isEmpty {
                                    HStack {
                                        Text("Pendientes\(taskViewModel.checkActivetask(id: idTaskFromPage) > 0 ? " - \(taskViewModel.checkActivetask(id: idTaskFromPage))" : "")")
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName: showActive ? "chevron.down" : "chevron.right")
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            showActive.toggle()
                                        }
                                    }
                                    .symbolEffect(.variableColor.reversing.iterative, value: showActive)
                                }
                            }
                            Section {
                                if showInactive {
                                    ForEach(taskViewModel.taskSearch) { item in
                                        if (item.taskPageItem?.id == idTaskFromPage) && (item.completed != false) {
                                            NavigationLink(destination: DetailTaskView(
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
                                    }
                                    .onDelete(perform: taskViewModel.removeTask)
                                }
                                
                            } header: {
                                if !taskViewModel.tasks.isEmpty {
                                    HStack {
                                        Text("Completadas\(taskViewModel.checkActivetask(is: true, id: idTaskFromPage) > 0 ? " - \(taskViewModel.checkActivetask(is: true, id: idTaskFromPage))" : "")")
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName: showInactive ? "chevron.down" : "chevron.right")
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            showInactive.toggle()
                                        }
                                    }
                                    .symbolEffect(.variableColor.reversing.iterative, value: showInactive)
        
                                }
                                
                                
                            }
                        }
                        .searchable(text: $taskvmBindable.search, prompt:"Buscar Tarea...")
                    } else {
                        Spacer()
                        Image(systemName: "list.clipboard")
                            .symbolEffect(.bounce, value: animationCount)
                            .font(.system(size: 100))
                            .onTapGesture {
                                animationCount += 1
                            }
                        if (titleSelected != "") && (taskViewModel.checkPageSelected() != nil) {
                            Text("Sin tareas en \(titleSelected)")
                        }
                        Spacer()
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
                                    titleSelected = "Seleccionar Página"
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
                            if let _ = taskViewModel.checkPageSelected() {
                                titleSelected = ""
                            } else {
                                titleSelected = "Seleccionar Página"
                            }
                            
                        }
                    },
                    toggleDeletedPage: { idPage in
                        withAnimation {
                            taskViewModel.removePages(with: idPage)
                            if let page = taskViewModel.checkPageSelected() {
                                idTaskFromPage = page.id
                                titleSelected = page.title
                            } else {
                                titleSelected = taskViewModel.pages.isEmpty ? "Añadir Página" : "Seleccionar Página"
                            }
                           
                            
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
            .navigationTitle(titleSelected.isEmpty ? "Añadir Página" :"\(titleSelected)" )
            
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
