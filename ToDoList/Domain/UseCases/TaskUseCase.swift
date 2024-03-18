import Foundation


class TaskUseCase: TaskUseCaseProtocol {
 
    private let swiftDataManager: SwiftDataManagerProtocol
    
    init(swiftDataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    
    func addTask(with title: String, idTaskPage: UUID) -> TaskItem? {
        let pages = swiftDataManager.fetchTaskPageItem()
        if let index = pages.firstIndex(where: {$0.id == idTaskPage}), !title.isEmpty {
            let newTask = TaskItem(
                title: title,
                date: Date(),
                status: TodoStatus.pending,
                note: "",
                lastUpdate: Date(),
                taskPageItem: pages[index]
            )
            newTask.tag = []
            pages[index].tasksItems.append(newTask)
            swiftDataManager.addTaskItem(item: newTask)
            return newTask
        }
        return nil
    }
    
    func toggleTaskCompletion(task: TaskItem) {
        let tasks = swiftDataManager.fetchTaskItem()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let status = task.status
            tasks[index].completed.toggle()
            switch status {
            case .completed:
                return tasks[index].status = .pending
            case .pending:
                tasks[index].lastUpdate = Date()
                return tasks[index].status = .completed
            }
        }
    }
    
    func removeTask(at index: IndexSet) -> Int? {
        let tasks = swiftDataManager.fetchTaskItem()
        for index in index {
            swiftDataManager.removeTaskItem(id: tasks[index].id)
            return index
        }
        return nil
    }
    
    func removeTasks(tasks: [TaskItem]) -> [TaskItem] {
        for task in tasks {
            swiftDataManager.removeTaskItem(id: task.id)
        }
        return swiftDataManager.fetchTaskItem()
    }

    
    func fetchAllTask() -> [TaskItem] {
        return swiftDataManager.fetchTaskItem()
    }
}
