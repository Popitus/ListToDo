import SwiftData
import SwiftUI

struct TaskView: View {
    // Properties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel

    @State private var newTaskTitle = String()
    @State private var checkTasks: [TasksLocal] = []
    @State private var titleSelected = ""
    @State private var idTaskFromPage = UUID()
    @State private var showActive = true
    @State private var showInactive = true
    @State private var pageSelected = false

    var body: some View {
        @Bindable var taskvmBindable = taskViewModel // <- @Environment object aren’t directly bindable

        NavigationView {
            VStack {
                if taskViewModel.pages.isEmpty {
                    EmptyPageView()
                } else {
                    if pageSelected && !checkTasks.isEmpty {
                        List {
                            Section {
                                if showActive {
                                    ForEach(taskViewModel.taskSearch) { item in
                                        if (item.taskPageItemID == idTaskFromPage) && (item.completed != true) {
                                            ListTask(item: item)
                                            printView("Tags: \(item)")
                                        }
                                    }
                                    .onDelete(perform: taskViewModel.removeTask)
                                }

                            } header: {
                                if !checkTasks.isEmpty {
                                    HStack {
                                        TitleSection(
                                            title: String(localized: "title_pending"),
                                            showActive: $showActive,
                                            idTaskFromPage: $idTaskFromPage
                                        )
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
                                        if (item.taskPageItemID == idTaskFromPage) && (item.completed != false) {
                                            ListTask(item: item)
                                        }
                                    }
                                    .onDelete(perform: taskViewModel.removeTask)
                                }

                            } header: {
                                if !checkTasks.isEmpty {
                                    HStack {
                                        TitleSection(
                                            title: String(localized: "title_completed"),
                                            conditional: true,
                                            showActive: $showInactive,
                                            idTaskFromPage: $idTaskFromPage
                                        )
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
                        .searchable(text: $taskvmBindable.search, prompt: "searchbox_task...")
                    } else {
                        EmptyTaskView(titleSelected: $titleSelected)
                    }
                }

                HorizontalPages(
                    pages: taskViewModel.pages,
                    toggleCompletionAddPage: {
                        alertTextField(
                            title: String(localized: "alert_title_category"),
                            message: String(localized: "alert_message_category"),
                            hintText: String(localized: "alert_title_category_placeholder"),
                            primaryTitle: String(localized: "button_add"),
                            secondaryTitle: String(localized: "button_discard"),
                            primaryAction: { text in
                                if !text.isEmpty {
                                    taskViewModel.addTaskPage(title: text)
                                    self.titleSelected = self.titleSelected.isEmpty ? String(localized: "title_select_category") : self.titleSelected
                                }
                            },
                            secondaryAction: {}
                        )
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
                .padding()

                AddTaskView(newTaskTitle: $newTaskTitle) {
                    if !newTaskTitle.isEmpty {
                        taskViewModel.addTask(title: newTaskTitle, idTaskPage: idTaskFromPage)
                        checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
                    }
                }
                .padding()
            }
            .navigationTitle(titleSelected.isEmpty ? String(localized: "title_add_category") : "\(titleSelected)")

            .onAppear {
                taskViewModel.fetchData()
                (idTaskFromPage, pageSelected) = taskViewModel.checkPageIdSelected()
                titleSelected = taskViewModel.titleSelected
                checkTasks = taskViewModel.tasks.filter { $0.taskPageItemID == idTaskFromPage }
            }
        }
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    return TaskView()
        .environment(taskViewModel)
}
