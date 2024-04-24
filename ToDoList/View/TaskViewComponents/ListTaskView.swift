import SwiftUI

extension TaskView {
    struct ListTasksView: View {
        @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
        @Binding var checkTasks: [TasksLocal]
        @Binding var titleSelected: String
        @Binding var idTaskFromPage: UUID
        @Binding var pageSelected: Bool
        
        var body: some View {
            Group {
                if pageSelected && !checkTasks.isEmpty {
                    List {
                        Section {
                            SectionListTaskView(idTaskFromPage: $idTaskFromPage, title: String(localized:"title_pending"),status: .pending)
                        }
                        Section {
                            SectionListTaskView(idTaskFromPage: $idTaskFromPage, title: String(localized:"title_inprocess"),status: .inProcess)
                        }
                        Section {
                            SectionListTaskView(idTaskFromPage: $idTaskFromPage, title: String(localized:"title_completed"), status: .completed)
                        }
                    }
                } else {
                    EmptyTaskView(titleSelected: $titleSelected)
                }
            }
        }
    }
}
