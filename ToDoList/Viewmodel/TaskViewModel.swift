import SwiftUI

@Observable
class TaskViewModel {
    @ObservationIgnored
    private let swiftDataManager: SwiftDataManager
    
    @ObservationIgnored
    private let taskUseCase: TaskUseCaseProtocol
    
    @ObservationIgnored
    private let taskPageUseCase: TaskPageUseCaseProtocol
    
    @ObservationIgnored
    private let tagUseCase: TagUseCaseProtocol
    
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
    var tasks: [TaskItem] = []
    var search: String = ""
    
    
    init(
        swiftDataManager: SwiftDataManager = SwiftDataManager.shared,
        taskUseCase: TaskUseCaseProtocol = TaskUseCase(),
        taskPageUseCase: TaskPageUseCaseProtocol = TaskPageUseCase(),
        tagUseCase: TagUseCaseProtocol = TagUseCase()) {
            
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
        tasks = taskUseCase.addTask(with: title, idTaskPage: idTaskPage)
    }
    
    func toggleTaskCompletion(task: TaskItem) {
        taskUseCase.toggleTaskCompletion(task: task)
    }
    
    func removeTask(at index: IndexSet) {
        tasks = taskUseCase.removeTask(at: index)
    }
    
    // MARK: TaskPageItems Functions
    
    func addTaskPage(title: String) {
        pages = taskPageUseCase.addTaskPage(title: title)
    }
    
    func togglePageSelection(page: TaskPageItem) {
        taskPageUseCase.togglePageSelection(page: page)
    }
    
    func removePages(with uuid: UUID) {
        pages = taskPageUseCase.removePages(with: uuid)
    }
    
    // MARK: Tags Functions
    
    func addTag(addTag: Tag, idTaskItem: UUID) {
        tags = tagUseCase.addTag(addTag: addTag, idTaskItem: idTaskItem)
    }
    
    func removeOneTag(tag: Tag) {
        tags = tagUseCase.removeOneTag(tag: tag)
    }
    
    func removeAllTag(tag: [Tag]) {
        tags = tagUseCase.removeAllTag(tag: tag)
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
