import SwiftUI

struct SectionListTaskView: View {
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    @State var show = true
    @Binding var idTaskFromPage: UUID
    var title: String
    var completed: Bool
    var body: some View {
        DisclosureGroup(
            isExpanded: $show,
            content: {
                ForEach(taskViewModel.taskSearch) { item in
                    if (item.taskPageItemID == idTaskFromPage) && (item.completed == completed) {
                        ListTask(item: item)
                    }
                }
                .onDelete(perform: taskViewModel.removeTask)
            },
            label: {
                Text("\(title)\(taskViewModel.checkActivetask(is: completed, id: idTaskFromPage) > 0 ? " - \(taskViewModel.checkActivetask(is: completed, id: idTaskFromPage))" : "")")
                    .foregroundStyle(.blue)
                    .font(.headline)
            }
        )
    }
}
