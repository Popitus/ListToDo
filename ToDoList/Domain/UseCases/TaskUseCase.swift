import Foundation

protocol TaskUseCaseProtocol {
    func addTask(with title: String, idTaskPage: UUID) -> [TaskItem]
    func toggleTaskCompletion(task: TaskItem)
    func removeTask(at index: IndexSet) -> [TaskItem]
    func removeTasks(tasks: [TaskItem]) -> [TaskItem]
    func fetchAllTask() -> [TaskItem]
}

class TaskUseCase: TaskUseCaseProtocol {
 
    private let swiftDataManager: SwiftDataManager
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    
    func addTask(with title: String, idTaskPage: UUID) -> [TaskItem]{
        let pages = swiftDataManager.fetchTaskPageItem()
        if let index = pages.firstIndex(where: {$0.id == idTaskPage}) {
            let newTask = TaskItem(
                title: title,
                date: Date(),
                status: TodoStatus.pending,
                note: "",
                lastUpdate: Date()
            )
            newTask.taskPageItem = pages[index]
            swiftDataManager.addTaskItem(item: newTask)
        }
        return swiftDataManager.fetchTaskItem()
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
    
    func removeTask(at index: IndexSet) -> [TaskItem] {
        let tasks = swiftDataManager.fetchTaskItem()
        for index in index {
            swiftDataManager.removeTaskItem(item: tasks[index])
        }
        return swiftDataManager.fetchTaskItem()
    }
    
    func removeTasks(tasks: [TaskItem]) -> [TaskItem] {
        for task in tasks {
            swiftDataManager.removeTaskItem(item: task)
        }
        return swiftDataManager.fetchTaskItem()
    }

    
    func fetchAllTask() -> [TaskItem] {
        return swiftDataManager.fetchTaskItem()
    }
}
