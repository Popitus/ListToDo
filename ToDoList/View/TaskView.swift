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
                                        TitleSection(
                                            title: String(localized:"title_pending"),
                                            showActive: $showActive,
                                            idTaskFromPage: $idTaskFromPage)
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
                                        TitleSection(
                                            title: String(localized:"title_completed"),
                                            conditional: true,
                                            showActive: $showInactive,
                                            idTaskFromPage: $idTaskFromPage)
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
                        .searchable(text: $taskvmBindable.search, prompt:"searchbox_task...")
                    } else {
                        EmptyTaskView(titleSelected: $titleSelected)
                    }
                }

                HorizontalPages(
                    pages: taskViewModel.pages,
                    toggleCompletionAddPage: {
                        alertTextField(
                            title: String(localized:"alert_title_category"),
                            message: String(localized:"alert_message_category"),
                            hintText: String(localized:"alert_title_category_placeholder"),
                            primaryTitle: String(localized:"button_add"),
                            secondaryTitle: String(localized:"button_discard"),
                            primaryAction: { text in
                                if !text.isEmpty {
                                    taskViewModel.addTaskPage(title: text)
                                    self.titleSelected = String(localized:"title_select_category")
                                }
                            },
                            secondaryAction: {})
                    },
                    toggleSelectedPage:  { page in
                        taskViewModel.togglePageSelection(page: page)
                        
                        if page.selected {
                            idTaskFromPage = page.id
                            self.titleSelected = page.title
                        } else {
                            idTaskFromPage = UUID()
                            if let _ = taskViewModel.checkPageSelected() {
                                self.titleSelected = ""
                            } else {
                                self.titleSelected = String(localized:"title_select_category")
                            }
                            
                        }
                        checkTasks = taskViewModel.tasks.filter({$0.taskPageItem?.id == idTaskFromPage})
                    },
                    toggleDeletedPage: { idPage in
                        withAnimation {
                            taskViewModel.removePages(with: idPage)
                            if let page = taskViewModel.checkPageSelected() {
                                idTaskFromPage = page.id
                                self.titleSelected = page.title
                            } else {
                                self.titleSelected = taskViewModel.pages.isEmpty ? String(localized:"title_add_category") : String(localized:"title_select_category")
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
            .navigationTitle(titleSelected.isEmpty ? String(localized:"title_add_category"):"\(titleSelected)" )
            .onChange(of: taskViewModel.tasks) { _, _ in
                checkTasks = taskViewModel.tasks.filter({$0.taskPageItem?.id == idTaskFromPage})
            }
            
            .onAppear {
                idTaskFromPage = taskViewModel.checkPageSelected()
                checkTasks = taskViewModel.tasks.filter({$0.taskPageItem?.id == idTaskFromPage})
                titleSelected = taskViewModel.titleSelected
            }
        }
    }
}

#Preview("Spanish") {
    @State var taskViewModel = TaskViewModel()
    return TaskView()
        .environment(taskViewModel)
}


#Preview("English") {
    @State var taskViewModel = TaskViewModel()
    return TaskView()
        .environment(taskViewModel)
        .environment(\.locale, .init(identifier: "en"))
}
