import SwiftUI
import SwiftData

struct TaskView: View {
    
    //Properties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var newTaskTitle = String()
    @State private var checkTasks: [TaskItem] = []
    @State private var titleSelected = ""
    @State private var idTaskFromPage = UUID()
    @State private var showActive = true
    @State private var showInactive = true
    
    
    var body: some View {
        @Bindable var taskvmBindable = taskViewModel //<- @Environment object aren’t directly bindable
        NavigationView {
            VStack {
                if taskViewModel.pages.isEmpty {
                    EmptyPageView()
                } else {
                    if (!checkTasks.isEmpty){
                        List {
                            Section {
                                if showActive {
                                    ForEach(taskViewModel.taskSearch) { item in
                                        if (item.taskPageItem?.id == idTaskFromPage) && (item.completed != true) {
                                            ListTask(item: item)
                                        }
                                    }
                                    .onDelete(perform: taskViewModel.removeTask)
                                }
                                
                            } header: {
                                if !taskViewModel.tasks.isEmpty {
                                    HStack {
                                        TitleSection(title: "Pendientes", showActive: $showActive, idTaskFromPage: $idTaskFromPage)
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
                                            ListTask(item: item)
                                        }
                                    }
                                    .onDelete(perform: taskViewModel.removeTask)
                                }
                                
                            } header: {
                                if !checkTasks.isEmpty {
                                    HStack {
                                        TitleSection(title: "Completadas", conditional: true, showActive: $showInactive, idTaskFromPage: $idTaskFromPage)
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
                        EmptyTaskView(
                            titleSelected: $titleSelected,
                            checkPagedSelected: taskViewModel.checkPageSelected()
                        )
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
                        checkTasks = taskViewModel.tasks.filter({$0.taskPageItem?.id == idTaskFromPage})
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
                        checkTasks = taskViewModel.tasks.filter({$0.taskPageItem?.id == idTaskFromPage})
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
            .onChange(of: taskViewModel.tasks) { _, _ in
                checkTasks = taskViewModel.tasks.filter({$0.taskPageItem?.id == idTaskFromPage})
            }
            
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
