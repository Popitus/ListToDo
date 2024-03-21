import Foundation

// MARK: - Usecases Protocols
protocol TaskPageUseCaseProtocol {
    func addTaskPage(title: String) -> TaskPageLocal?
    func togglePageSelection(page: TaskPageLocal) -> [TaskPageLocal]
    func removePages(with uuid: UUID) -> Int?
    func fetchAllPages() -> [TaskPageLocal]
}

protocol TaskUseCaseProtocol {
    func addTask(with title: String, idTaskPage: UUID) -> TaskItem?
    func toggleTaskCompletion(task: TaskItem)
    func removeTask(at index: IndexSet) -> Int?
    func removeTasks(tasks: [TaskItem]) -> [TaskItem]
    func fetchAllTask() -> [TaskItem]
}

protocol TagUseCaseProtocol {
    func addTag(withTitle title: String, idTaskItem: UUID) -> TagItem?
    func removeOneTag(withId id: UUID) -> Int?
    func removeAllTag(tag: [TagItem]) -> [TagItem]
    func fetchAllTags() -> [TagItem]
}

// MARK: - SwiftdataManager Protocols

protocol SwiftDataManagerProtocol {
    func addTaskItem(item: TaskItem)
    func fetchTaskItem() -> [TaskItem]
    func removeTaskItem(id: UUID)
    func addTaskPageItem(item: TaskPageItem)
    func fetchTaskPageItem() -> [TaskPageItem]
    func removeTaskPageItem(id: UUID)
    func addTagToTask(tag: TagItem)
    func fetchTags() -> [TagItem]
    func removeTagTask(id: UUID)
}

