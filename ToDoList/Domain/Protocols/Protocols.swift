import Foundation

// MARK: - Usecases Protocols
protocol TaskPageUseCaseProtocol {
    func addTaskPage(title: String) -> [TaskPageItem]
    func togglePageSelection(page: TaskPageItem)
    func removePages(with uuid: UUID) -> [TaskPageItem]
    func fetchAllPages() -> [TaskPageItem]
}

protocol TaskUseCaseProtocol {
    func addTask(with title: String, idTaskPage: UUID) -> [TaskItem]
    func toggleTaskCompletion(task: TaskItem)
    func removeTask(at index: IndexSet) -> [TaskItem]
    func removeTasks(tasks: [TaskItem]) -> [TaskItem]
    func fetchAllTask() -> [TaskItem]
}

protocol TagUseCaseProtocol {
    func addTag(withTitle title: String, idTaskItem: UUID, idTag: UUID) -> [Tag]
    func removeOneTag(withId id: UUID) -> [Tag]
    func removeAllTag(tag: [Tag]) -> [Tag]
    func fetchAllTags() -> [Tag]
}

// MARK: - SwiftdataManager Protocols

protocol SwiftDataManagerProtocol {
    func addTaskItem(item: TaskItem)
    func fetchTaskItem() -> [TaskItem]
    func removeTaskItem(item: TaskItem)
    func addTaskPageItem(item: TaskPageItem)
    func fetchTaskPageItem() -> [TaskPageItem]
    func removeTaskPageItem(item: TaskPageItem)
    func addTagToTask(tag: Tag)
    func fetchTags() -> [Tag]
    func removeTagTask(tag: Tag)
}

