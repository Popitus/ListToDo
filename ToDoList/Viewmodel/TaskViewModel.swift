import SwiftUI

@Observable
class TaskViewModel {
    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager
    
    var tasks: [TaskItem] = []
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
        self.tasks = swiftDataManager.fetchTaskItem()
    }

    func addTask(title: String) {
        let newTask = TaskItem(title: title)
        swiftDataManager.addTaskItem(item: newTask)
        tasks.append(newTask)
    }

    func toggleTaskCompletion(task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completed.toggle()
        }
    }

    func removeTask(at index: IndexSet) {
        for index in index {
            swiftDataManager.removeTaskItem(item: tasks[index])
            tasks.remove(at: index)
        }
    }
}
