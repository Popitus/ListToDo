import SwiftData
import SwiftUI

struct TaskView: View {
    
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var newTaskTitle = String()
    @State private var checkTasks: [TasksLocal] = []
    @State private var titleSelected = ""
    @State private var idTaskFromPage = UUID()
    @State private var showActive = true
    @State private var showInactive = true
    @State private var pageSelected = false
    @State private var showNewCategory = false
    
    var body: some View {
        @Bindable var taskvmBindable = taskViewModel // <- @Environment object aren’t directly bindable
        NavigationView {
            ZStack {
                VStack {
                    if taskViewModel.pages.isEmpty {
                        EmptyPageView()
                    } else {
                       ListTasksView(checkTasks: $checkTasks, titleSelected: $titleSelected, idTaskFromPage: $idTaskFromPage, showActive: $showActive, showInactive: $showInactive, pageSelected: $pageSelected)
                            .searchable(text: $taskvmBindable.search, prompt: "searchbox_task...")
                    }
                      
                    HorizontalPagesView(checkTasks: $checkTasks, titleSelected: $titleSelected, idTaskFromPage: $idTaskFromPage, pageSelected: $pageSelected, showNewCategory: $showNewCategory)
                    .padding()
                    
                    if !taskViewModel.pages.isEmpty {
                        AddTaskView(newTaskTitle: $newTaskTitle) {
                            if !newTaskTitle.isEmpty {
                                taskViewModel.addTask(title: newTaskTitle, idTaskPage: idTaskFromPage)
                                checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
                            }
                        }
                        .padding()
                    }
                    
                }
                .opacity(showNewCategory ? 0.3 : 1)
                if showNewCategory {
                    AlertPopUp(title: String(localized: "alert_title_category"),
                               message: String(localized: "alert_message_category"),
                               hintText: String(localized: "alert_title_category_placeholder"),
                               primaryTitle: String(localized: "button_add"),
                               secondaryTitle: String(localized: "button_discard")) { text in
                        if !text.isEmpty {
                            taskViewModel.addTaskPage(title: text)
                            self.titleSelected = self.titleSelected.isEmpty ? String(localized: "title_select_category") : self.titleSelected
                            
                            if taskViewModel.pages.count == 1 {
                                titleSelected = text
                            }
                            showNewCategory.toggle()
                        }
                    } secondaryAction: {
                        showNewCategory.toggle()
                    }
                    .padding(40)
                }
            }
            .navigationTitle(titleSelected.isEmpty ? String(localized: "title_add_category") : "\(titleSelected)")
            
            .onAppear {
                taskViewModel.fetchData()
                (idTaskFromPage, pageSelected) = taskViewModel.checkPageIdSelected()
                titleSelected = taskViewModel.titleSelected
                checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
            }
            
            .onChange(of: taskViewModel.tasks) {
                checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
            }
        }
    }
}

#Preview {
    TaskView()
        .environment(TaskViewModel())
}

extension TaskView {
    struct HeaderSectionPendingTasksView: View {
        var checkTasks: Bool
        var title: String
        @Binding var showActive: Bool
        @Binding var idTaskFromPage: UUID
        
        var body: some View {
            if checkTasks {
                Button {
                    withAnimation {
                        showActive.toggle()
                    }
                } label: {
                    HStack {
                        TitleSection(
                            title: title,
                            showActive: $showActive,
                            idTaskFromPage: $idTaskFromPage
                        )
                    }
                }
                .symbolEffect(.variableColor.reversing.iterative, value: showActive)
            }
        }
    }
    
    struct HeaderSectionCompletedTasksView: View {
        var checkTasks: Bool
        var title: String
        @Binding var showInactive: Bool
        @Binding var idTaskFromPage: UUID
        
        var body: some View {
            if checkTasks {
                Button {
                    withAnimation {
                        showInactive.toggle()
                    }
                } label: {
                    HStack {
                        TitleSection(
                            title: title,
                            conditional: true,
                            showActive: $showInactive,
                            idTaskFromPage: $idTaskFromPage
                        )
                    }
                }
                .symbolEffect(.variableColor.reversing.iterative, value: showInactive)
            }
        }
    }
    
    struct ListTasksView: View {
        @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
        @Binding var checkTasks: [TasksLocal]
        @Binding var titleSelected: String
        @Binding var idTaskFromPage: UUID
        @Binding var showActive: Bool
        @Binding var showInactive: Bool
        @Binding var pageSelected: Bool

        var body: some View {
            Group {
                if pageSelected && !checkTasks.isEmpty {
                    List {
                        Section {
                            if showActive {
                                ForEach(taskViewModel.taskSearch) { item in
                                    if (item.taskPageItemID == idTaskFromPage) && (item.completed != true) {
                                        ListTask(item: item)
                                    }
                                }
                                .onDelete(perform: taskViewModel.removeTask)
                            }
                        } header: {
                            HeaderSectionPendingTasksView(checkTasks: !checkTasks.isEmpty, title: String(localized: "title_pending"), showActive: $showActive, idTaskFromPage: $idTaskFromPage)
                        }
                        Section {
                            if showInactive {
                                ForEach(taskViewModel.taskSearch) { item in
                                    if (item.taskPageItemID == idTaskFromPage) && (item.completed != false) {
                                        ListTask(item: item)
                                    }
                                }
                                .onDelete(perform: taskViewModel.removeTask)
                            }
                            
                        } header: {
                            HeaderSectionCompletedTasksView(checkTasks: !checkTasks.isEmpty, title: String(localized: "title_completed"), showInactive: $showInactive, idTaskFromPage: $idTaskFromPage)
                        }
                    }
                    
                } else {
                    EmptyTaskView(titleSelected: $titleSelected)
                }
            }
        }
    }
    
    struct HorizontalPagesView: View {
        @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
        @Binding var checkTasks: [TasksLocal]
        @Binding var titleSelected: String
        @Binding var idTaskFromPage: UUID
        @Binding var pageSelected: Bool
        @Binding var showNewCategory: Bool
        var body: some View {
            HorizontalPages(
                pages: taskViewModel.pages,
                toggleCompletionAddPage: {
                    showNewCategory.toggle()
                },
                toggleSelectedPage: { page in
                    taskViewModel.togglePageSelection(page: page)
                    if !page.selected {
                        pageSelected = true
                        idTaskFromPage = page.id
                        self.titleSelected = page.title
                    } else {
                        pageSelected = false
                        idTaskFromPage = UUID()
                        if let _ = taskViewModel.checkPageSelected() {
                            self.titleSelected = ""
                        } else {
                            self.titleSelected = String(localized: "title_select_category")
                        }
                    }
                    checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
                },
                toggleDeletedPage: { idPage in
                    withAnimation {
                        pageSelected = false
                        taskViewModel.removePages(with: idPage)
                        if let page = taskViewModel.checkPageSelected() {
                            self.titleSelected = page.title
                        } else {
                            self.titleSelected = taskViewModel.pages.isEmpty ? String(localized: "title_add_category") : String(localized: "title_select_category")
                        }
                        (self.idTaskFromPage, self.pageSelected) = taskViewModel.checkPageIdSelected()
                        checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
                    }
                }
            )
        }
    }
}
