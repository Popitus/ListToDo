import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []

    func addTask(title: String) {
        let newTask = TaskItem(title: title)
        tasks.append(newTask)
    }

    func toggleTaskCompletion(task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completed.toggle()
        }
    }

    func removeTask(at index: IndexSet) {
        tasks.remove(atOffsets: index)
    }
}
