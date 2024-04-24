import SwiftUI

extension TaskView {
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
