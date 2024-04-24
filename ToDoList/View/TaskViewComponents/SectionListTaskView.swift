import SwiftUI

struct SectionListTaskView: View {
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    @State var show = true
    @Binding var idTaskFromPage: UUID
    var title: String
    var status: TodoStatus
    var body: some View {
        DisclosureGroup(
            isExpanded: $show,
            content: {
                ForEach(taskViewModel.taskSearch) { item in
                    if (item.taskPageItemID == idTaskFromPage) && (item.status == status) {
                        ListTask(item: item)
                    }
                }
                .onDelete(perform: taskViewModel.removeTask)
            },
            label: {
                Text("\(title)\(taskViewModel.checkStatusTasks(status, id: idTaskFromPage) > 0 ? " - \(taskViewModel.checkStatusTasks(status, id: idTaskFromPage))" : "")")
                    .foregroundStyle(.blue)
                    .font(.headline)
            }
        )
    }
}
