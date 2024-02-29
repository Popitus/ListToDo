import SwiftUI

@Observable
class TaskViewModel {
    
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
        taskUseCase: TaskUseCaseProtocol = TaskUseCase(),
        taskPageUseCase: TaskPageUseCaseProtocol = TaskPageUseCase(),
        tagUseCase: TagUseCaseProtocol = TagUseCase()) {
            
            self.taskUseCase = taskUseCase
            self.taskPageUseCase = taskPageUseCase
            self.tagUseCase = tagUseCase
            fetchData()
            
        }
    
    func fetchData() {
        self.pages = taskPageUseCase.fetchAllPages()
        self.tasks = taskUseCase.fetchAllTask()
        self.tags = tagUseCase.fetchAllTags()
    }
    
    // MARK: TaskItems functions
    
    func addTask(title: String, idTaskPage: UUID) {
        tasks = taskUseCase.addTask(with: title, idTaskPage: idTaskPage)
        print("AUX Task -> AddTask: \(tasks.map({$0.title})) - \(tasks.map({$0.tag?.map({$0.title})})) ")

    }
    
    func toggleTaskCompletion(task: TaskItem) {
        taskUseCase.toggleTaskCompletion(task: task)
    }
    
    func removeTask(at index: IndexSet) {
        tasks = taskUseCase.removeTask(at: index)
        print("AUX Task -> RemoveTask: \(tasks.map({$0.title})) - \(tasks.map({$0.tag?.map({$0.title})})) ")
    }
    
    // MARK: TaskPageItems Functions
    
    func addTaskPage(title: String) {
        pages = taskPageUseCase.addTaskPage(title: title)
        print("AUX Pages -> AddPage: \(pages.map({$0.title})) - \(pages.map({$0.tasksItems?.map({$0.title})})) ")
    }
    
    func togglePageSelection(page: TaskPageItem) {
        taskPageUseCase.togglePageSelection(page: page)
    }
    
    func removePages(with uuid: UUID) {
        pages = taskPageUseCase.removePages(with: uuid)
        print("AUX Pages -> RemovePage: \(pages.map({$0.title})) - \(pages.map({$0.tasksItems?.map({$0.title})})) ")
    }
    
    // MARK: Tags Functions
    
    func addTag(addTag: Tag, idTaskItem: UUID) {
        tags = tagUseCase.addTag(addTag: addTag, idTaskItem: idTaskItem)
        print("AUX Tags -> AddTag: \(tags.map({$0.title}))")
    }
    
    func removeOneTag(tag: Tag) {
        tags = tagUseCase.removeOneTag(tag: tag)
        print("AUX Tags -> RemoveOneTag: \(tags.map({$0.title}))")
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
