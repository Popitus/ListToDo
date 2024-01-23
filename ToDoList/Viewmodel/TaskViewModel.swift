import SwiftUI

@Observable
class TaskViewModel {
    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager
    
    var tasks: [TaskItem] = []
    var pages: [TaskPageItem] = []
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
        self.pages = swiftDataManager.fetchTaskPageItem()
        self.tasks = swiftDataManager.fetchTaskItem()
    }
    
    // MARK: TaskItems functions
   
    func addTask(title: String, idTaskPage: UUID) {
       
        if let index = pages.firstIndex(where: {$0.id == idTaskPage}) {
            let newTask = TaskItem(
                title: title,
                date: Date(),
                status: TodoStatus.pending
            )
            newTask.taskPageItem = pages[index]
            swiftDataManager.addTaskItem(item: newTask)
            tasks = swiftDataManager.fetchTaskItem()
        }
        
    }
    
    func toggleTaskCompletion(task: TaskItem, withPageId uuid: UUID) {
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
        print("tasks BF: \(tasks.map{$0.title})")
        for index in index {
            swiftDataManager.removeTaskItem(item: tasks[index])
        }
        tasks = swiftDataManager.fetchTaskItem()
    }
    
    // MARK: TaskPageItems Functions
    
    func addTaskPage(title: String) {
        let newTaskPage = TaskPageItem(title: title)
        swiftDataManager.addTaskPageItem(item: newTaskPage)
        pages = swiftDataManager.fetchTaskPageItem()
    }
    
    func togglePageSelection(page: TaskPageItem) {
        guard let index = pages.firstIndex(where: { $0.id == page.id }) else {
            return
        }
        pages[index].selected.toggle()
        pages.indices
            .filter { $0 != index }
            .forEach { pages[$0].selected = false }
    }
    
    func removePages(with uuid: UUID) {
        if let index = pages.firstIndex(where: {$0.id == uuid}) {
            swiftDataManager.removeTaskPageItem(item: pages[index])
            pages = swiftDataManager.fetchTaskPageItem()
            tasks = swiftDataManager.fetchTaskItem()
        }
    }
    
    // MARK: Utils functions
    func checkPageSelected() -> UUID {
        if let selectedPage =  pages.firstIndex(where: {$0.selected == true }) {
            return pages[selectedPage].id
        } else {
            return UUID()
        }
    }
    
}
