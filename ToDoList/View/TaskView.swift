import SwiftData
import SwiftUI

struct TaskView: View {
    
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var newTaskTitle = String()
    @State private var checkTasks: [TasksLocal] = []
    @State private var titleSelected = ""
    @State private var idTaskFromPage = UUID()
    @State private var pageSelected = false
    @State private var showNewCategory = false
    
    var body: some View {
        @Bindable var taskvmBindable = taskViewModel // <- @Environment object aren’t directly bindable
        ZStack {
            VStack {
                if taskViewModel.pages.isEmpty {
                    EmptyPageView()
                } else {
                    ListTasksView(checkTasks: $checkTasks, titleSelected: $titleSelected, idTaskFromPage: $idTaskFromPage, pageSelected: $pageSelected)
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
                        
                        //Activa la Page al ser creada
                        titleSelected = text
                        if let index = taskViewModel.pages.firstIndex(where: { $0.title == titleSelected }) {
                            taskViewModel.pages[index].selected = true
                            let selectedPage =  taskViewModel.pages[index]
                            taskViewModel.togglePageSelection(page: selectedPage)
                            idTaskFromPage = selectedPage.id
                        }
                        showNewCategory.toggle()
                    }
                } secondaryAction: {
                    showNewCategory.toggle()
                }
                .padding(40)
                .transition(AnyTransition.slide)
            }
        }
        .animation(.default, value: showNewCategory)
        .navigationTitle(titleSelected.isEmpty ? String(localized: "title_add_category") : "\(titleSelected)")
        
        .onAppear {
            taskViewModel.fetchData()
            (idTaskFromPage, pageSelected) = taskViewModel.checkPageIdSelected()
            titleSelected = taskViewModel.titleSelected
            checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
        }
        
        .onChange(of: taskViewModel.tasks) {
            (idTaskFromPage, pageSelected) = taskViewModel.checkPageIdSelected()
            checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
        }
    }
}

#Preview {
    NavigationView{
        TaskView()
    }
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
}
