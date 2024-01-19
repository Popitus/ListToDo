import SwiftUI

@Observable
class TaskViewModel {
    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager
    
    var tasks: [TaskItem] = []
    var pages: [TaskPageItem] = []
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
        self.tasks = swiftDataManager.fetchTaskItem()
        self.pages = swiftDataManager.fetchTaskPageItem()
    }
    
    // MARK: TaskItems functions
    func addTask(title: String, idTaskPage: UUID) {
        let newTask = TaskItem(
            title: title,
            date: Date(),
            status: TodoStatus.pending
        )
        if let index = pages.firstIndex(where: {$0.id == idTaskPage}) {
            swiftDataManager.addTaskItem(item: newTask)
            tasks.append(newTask)
        }
        
    }
    
    func toggleTaskCompletion(task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let status = task.status
            tasks[index].completed.toggle()
            switch status {
            case .completed:
                return tasks[index].status = .pending
            case .pending:
                return tasks[index].status = .completed
            }
        }
    }
    
    func removeTask(at index: IndexSet) {
        for index in index {
            swiftDataManager.removeTaskItem(item: tasks[index])
            tasks.remove(at: index)
        }
    }
    
    // MARK: TaskPageItems Functions
    
    func addTaskPage(title: String) {
        let newTaskPage = TaskPageItem(title: title)
        swiftDataManager.addTaskPageItem(item: newTaskPage)
        pages.append(newTaskPage)
    }
    
    func togglePageSelection(page: TaskPageItem) {
        guard let index = pages.firstIndex(where: { $0.id == page.id }) else {
            return
        }
        let selectedPage = pages[index].selected
        pages[index].selected.toggle()
        pages.indices
            .filter { $0 != index }
            .forEach { pages[$0].selected = false }
    }
    
    func removePages(with uuid: UUID) {
        if let index = pages.firstIndex(where: {$0.id == uuid}) {
            swiftDataManager.removeTaskPageItem(item: pages[index])
            pages.remove(at: index)
        }
    }
    
}
