import SwiftUI

@Observable
class TaskViewModel {
    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager
    
    
    var tasks: [TaskItem] = []
    
    var taskSearch: [TaskItem] {
        guard !search.isEmpty else { return tasks }
        return tasks.filter { task in
            task.title.lowercased().contains(search.lowercased())
        }
    }
    
    var activeTasks: Int {
        let falseElements = tasks.filter { $0.completed == false }
        return falseElements.count
    }
    
    var inactiveTasks: Int {
        let trueElements = tasks.filter { $0.completed == true }
        return trueElements.count
    }
    
    var pages: [TaskPageItem] = []
    var tags: [Tag] = []
    var search: String = ""
    
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
        self.pages = swiftDataManager.fetchTaskPageItem()
        self.tasks = swiftDataManager.fetchTaskItem()
        self.tags = swiftDataManager.fetchTags()
        
        print("Fetch tags: \(tags.map{$0.title}) - \(tags.map{$0.taskItem?.title}) ")
        print("Fetch tasks: \(tasks.map{$0.tag?.map{$0.title}})")
        
    }
    
    // MARK: TaskItems functions
    
    func addTask(title: String, idTaskPage: UUID) {
        
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
            tasks = swiftDataManager.fetchTaskItem()
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
                tasks[index].lastUpdate = Date()
                return tasks[index].status = .completed
            }
        }
    }
    
    func removeTask(at index: IndexSet) {
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
    
    func checkPageSelected() -> TaskPageItem? {
        if let index = pages.firstIndex(where: { $0.selected == true }) {
            return pages[index]
        } else {
            return nil
        }
    }
    
    func removePages(with uuid: UUID) {
        if let index = pages.firstIndex(where: {$0.id == uuid}) {
            swiftDataManager.removeTaskPageItem(item: pages[index])
            pages = swiftDataManager.fetchTaskPageItem()
            tasks = swiftDataManager.fetchTaskItem()
        }
    }
    
    // MARK: Tags Functions
    
    func addTag(addTag: Tag, idTaskItem: UUID) {
        if let index = tasks.firstIndex(where: {$0.id == idTaskItem}) {
            if !addTag.title.isEmpty {
                addTag.taskItem = tasks[index]
                swiftDataManager.addTagToTask(tag: addTag)
                tags = swiftDataManager.fetchTags()
            } else {
                removeOneTag(tag: addTag)
            }
            tasks[index].lastUpdate = Date()
        }
    }
    
    func removeOneTag(tag: Tag) {
        if let index = tags.firstIndex(where: {$0.id == tag.id}) {
            swiftDataManager.removeTagTask(tag: tags[index])
            tags = swiftDataManager.fetchTags()
        }
    }
    
    func removeAllTag(tag: [Tag]) {
        for tags in tags {
            swiftDataManager.removeTagTask(tag: tags)
        }
        tags = swiftDataManager.fetchTags()
    }
    
    // MARK: Utils functions
    func checkPageSelected() -> UUID {
        if let selectedPage =  pages.firstIndex(where: {$0.selected == true }) {
            return pages[selectedPage].id
        } else {
            return UUID()
        }
    }
    
    func checkActivetask(is inactive: Bool = false, id: UUID) -> Int {
        let trueElements = tasks.filter { element in
            
            if inactive {
                element.completed == true && element.taskPageItem?.id == id
            } else {
                element.completed == false && element.taskPageItem?.id == id
            }
            
        }
        return trueElements.count
    }
}
