import SwiftUI

@Observable
class TaskViewModel {
    @ObservationIgnored
    private let taskUseCase: TaskUseCaseProtocol

    @ObservationIgnored
    private let taskPageUseCase: TaskPageUseCaseProtocol

    @ObservationIgnored
    private let tagUseCase: TagUseCaseProtocol

    var taskSearch: [TasksLocal] {
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
            return pages.count >= 0 ? String(localized: "title_select_category") : ""
        }
    }

    var pages: [TaskPageLocal] = []
    var tags: [TagLocal] = []
    var tasks: [TasksLocal] = []
    var search: String = ""

    init(
        taskUseCase: TaskUseCaseProtocol = TaskUseCase(),
        taskPageUseCase: TaskPageUseCaseProtocol = TaskPageUseCase(),
        tagUseCase: TagUseCaseProtocol = TagUseCase()
    ) {
        self.taskUseCase = taskUseCase
        self.taskPageUseCase = taskPageUseCase
        self.tagUseCase = tagUseCase

        fetchData()
    }

    func fetchData() {
        pages = taskPageUseCase.fetchAllPages()
        tasks = taskUseCase.fetchAllTask()
        tags = tagUseCase.fetchAllTags()
    }

    // MARK: TaskItems functions

    func addTask(title: String, idTaskPage: UUID) {
        if let task = taskUseCase.addTask(with: title, idTaskPage: idTaskPage) {
            tasks.append(task)
        }
    }

    func toggleTaskCompletion(task: TasksLocal) {
        tasks = taskUseCase.toggleTaskCompletion(task: task)
    }

    func removeTask(at index: IndexSet) {
        if let index = taskUseCase.removeTask(at: index) {
            tasks.remove(at: index)
        }
        tags = tagUseCase.fetchAllTags()
    }

    // MARK: TaskPageItems Functions

    func addTaskPage(title: String) {
        if let page = taskPageUseCase.addTaskPage(title: title) {
            pages.append(page)
        }
    }

    func togglePageSelection(page: TaskPageLocal) {
        pages = taskPageUseCase.togglePageSelection(page: page)
    }

    func removePages(with uuid: UUID) {
        if let index = taskPageUseCase.removePages(with: uuid) {
            pages.remove(at: index)
        }
        pages = taskPageUseCase.fetchAllPages()
        tasks = taskUseCase.fetchAllTask()
    }

    // MARK: Tags Functions

    func addTag(title: String, idTaskItem: UUID, idTag: UUID) {
        tags = tagUseCase.fetchAllTags()
        if !tags.isEmpty, tags.contains(where: { $0.id == idTag }) {
            return
        } else {
            if let tag = tagUseCase.addTag(withTitle: title, idTaskItem: idTaskItem) {
                tags.append(tag)
                if let index = tasks.firstIndex(where: { $0.id == idTaskItem }) {
                    tasks[index].tag.append(tag)
                }
            }
        }
    }

    func removeOneTag(id: UUID) {
        if let index = tagUseCase.removeOneTag(withId: id) {
            tags.remove(at: index)
        }
    }

    func removeAllTag(tag: [TagLocal]) {
        tags = tagUseCase.removeAllTag(tag: tag)
    }

    // MARK: Utils functions

    func checkPageIdSelected() -> (UUID, Bool) {
        if let selectedPage = pages.firstIndex(where: { $0.selected == true }) {
            return (pages[selectedPage].id, true)
        } else {
            return (UUID(), false)
        }
    }

    func checkPageSelected() -> TaskPageLocal? {
        if let index = pages.firstIndex(where: { $0.selected == true }) {
            return pages[index]
        } else {
            return nil
        }
    }

    func checkActivetask(is inactive: Bool = false, id: UUID) -> Int {
        let trueElements = tasks.filter { element in
            if inactive {
                element.completed == true && element.taskPageItemID == id
            } else {
                element.completed == false && element.taskPageItemID == id
            }
        }
        return trueElements.count
    }
}
