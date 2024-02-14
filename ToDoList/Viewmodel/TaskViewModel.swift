import SwiftUI

@Observable
class TaskViewModel {
    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager
    
    @ObservationIgnored
    private let taskUseCase: TaskUseCase
    
    @ObservationIgnored
    private let taskPageUseCase: TaskPageUseCase
    
    @ObservationIgnored
    private let tagUseCase: TagUseCase
    
    
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
    
    var titleSelected: String {
        let page = pages.filter { $0.selected == true }
        if let title = page.first?.title {
            return title
        } else {
            return pages.count > 0 ? String(localized:"title_select_category") : ""
        }
        
    }
    
    var pages: [TaskPageItem] = []
    var tags: [Tag] = []
    var search: String = ""
    
    
    init(
        swiftDataManager: SwiftDataManager = SwiftDataManager.shared,
        taskUseCase: TaskUseCase = TaskUseCase(),
        taskPageUseCase: TaskPageUseCase = TaskPageUseCase(),
        tagUseCase: TagUseCase = TagUseCase()) {
            
            self.swiftDataManager = swiftDataManager
            
            self.pages = swiftDataManager.fetchTaskPageItem()
            self.tasks = swiftDataManager.fetchTaskItem()
            self.tags = swiftDataManager.fetchTags()
            
            self.taskUseCase = taskUseCase
            self.taskPageUseCase = taskPageUseCase
            self.tagUseCase = tagUseCase
            
        }
    
    // MARK: TaskItems functions
    
    func addTask(title: String, idTaskPage: UUID) {
        taskUseCase.addTask(with: title, idTaskPage: idTaskPage)
        tasks = swiftDataManager.fetchTaskItem()
    }
    
    func toggleTaskCompletion(task: TaskItem) {
        taskUseCase.toggleTaskCompletion(task: task)
    }
    
    func removeTask(at index: IndexSet) {
        taskUseCase.removeTask(at: index)
        tasks = swiftDataManager.fetchTaskItem()
    }
    
    // MARK: TaskPageItems Functions
    
    func addTaskPage(title: String) {
        taskPageUseCase.addTaskPage(title: title)
        pages = swiftDataManager.fetchTaskPageItem()
    }
    
    func togglePageSelection(page: TaskPageItem) {
        taskPageUseCase.togglePageSelection(page: page)
    }
    
    func removePages(with uuid: UUID) {
        taskPageUseCase.removePages(with: uuid)
        pages = swiftDataManager.fetchTaskPageItem()
        tasks = swiftDataManager.fetchTaskItem()
    }
    
    // MARK: Tags Functions
    
    func addTag(addTag: Tag, idTaskItem: UUID) {
        tagUseCase.addTag(addTag: addTag, idTaskItem: idTaskItem)
        tags = swiftDataManager.fetchTags()
    }
    
    func removeOneTag(tag: Tag) {
        tagUseCase.removeOneTag(tag: tag)
        tags = swiftDataManager.fetchTags()
    }
    
    func removeAllTag(tag: [Tag]) {
        tagUseCase.removeAllTag(tag: tag)
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
    
    func checkPageSelected() -> TaskPageItem? {
        if let index = pages.firstIndex(where: { $0.selected == true }) {
            return pages[index]
        } else {
            return nil
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
