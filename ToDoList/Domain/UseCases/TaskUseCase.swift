import Foundation

protocol TaskUseCaseProtocol {
    func addTask(with title: String, idTaskPage: UUID)
    func toggleTaskCompletion(task: TaskItem)
    func removeTask(at index: IndexSet)
}

class TaskUseCase: TaskUseCaseProtocol {
 
    private let swiftDataManager: SwiftDataManager
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTask(with title: String, idTaskPage: UUID) {
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
    
    func removeTask(at index: IndexSet) {
        let tasks = swiftDataManager.fetchTaskItem()
        for index in index {
            swiftDataManager.removeTaskItem(item: tasks[index])
        }
    }
    
}