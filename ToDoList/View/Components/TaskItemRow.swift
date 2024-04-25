import SwiftUI

struct TaskItemRow: View {

    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    var task: TasksLocal

    var body: some View {
        VStack {
            HStack {
                Text(task.title)
                    .strikethrough(task.completed)
                    .foregroundColor(task.completed ? .gray : .primary)
                    .font(.title3)

                Spacer()
                Button {
                    withAnimation {
                        taskViewModel.toggleTaskStatus(task: task)
                    }
                } label: {
                        StatusIndicator(status: task.status)
                    }
            }
            HStack {
                task.sticker.image
                    .font(.title)
                Text(task.lastUpdate.format())
                    .strikethrough(task.completed)
                    .foregroundColor(.gray)
                    .font(.subheadline)

                Spacer()
            }
            HStack {
                if taskViewModel.tags.filter({ $0.taskItemID == task.id }) != [] {
                    Image(systemName: "tag.circle")
                        .padding(.vertical, 4)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(taskViewModel.tags.filter { $0.taskItemID == task.id }) { tag in
                                TagsListView(tag: tag.title)
                            }
                        }
                    }
                    Spacer()
                }
                if !task.note.isEmpty {
                    Spacer()
                    Image(systemName: "text.bubble")
                        .padding(.vertical, 4)
                }
            }
        }
    }
}

#Preview {
    TaskItemRow(
        task: .sample)
        .environment(TaskViewModel.preview)
}
