import Foundation

class TaskUseCase: TaskUseCaseProtocol {
    private let swiftDataManager: SwiftDataManagerProtocol

    init(swiftDataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }

    func addTask(with title: String, idTaskPage: UUID) -> TasksLocal? {
        let pages = swiftDataManager.fetchTaskPageItem()
        if let index = pages.firstIndex(where: { $0.id == idTaskPage }), !title.isEmpty {
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
            return TaskMapper.mapToDomain(taskItem: newTask)
        }
        return nil
    }

    func toggleTaskStatus(task: TasksLocal) -> [TasksLocal] {
        let tasks = swiftDataManager.fetchTaskItem()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let status = task.status
            switch status {
            case .completed:
                tasks[index].status = .pending
                tasks[index].completed = false
            case .inProcess:
                tasks[index].lastUpdate = Date()
                tasks[index].status = .completed
                tasks[index].completed = true
            case .pending:
                tasks[index].lastUpdate = Date()
                tasks[index].status = .inProcess
                tasks[index].completed = false
            }
        }
        return tasks.map { TaskMapper.mapToDomain(taskItem: $0) }
    }

    func removeTask(at index: IndexSet) -> Int? {
        let tasks = swiftDataManager.fetchTaskItem()
        for index in index {
            swiftDataManager.removeTaskItem(id: tasks[index].id)
            return index
        }
        return nil
    }
    
    func updateTask(task: TasksLocal) -> [TasksLocal] {
        let tasks = swiftDataManager.fetchTaskItem()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = task.title
            tasks[index].note = task.note
        }
        return fetchAllTask()
    }
    
    

    func removeTasks(tasks: [TasksLocal]) -> [TasksLocal] {
        for task in tasks {
            swiftDataManager.removeTaskItem(id: task.id)
        }
        return fetchAllTask()
    }

    func fetchAllTask() -> [TasksLocal] {
        let tasks = swiftDataManager.fetchTaskItem().map { TaskMapper.mapToDomain(taskItem: $0) }
        return tasks
    }
}
