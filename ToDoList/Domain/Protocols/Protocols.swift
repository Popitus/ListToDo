import Foundation

// MARK: - Usecases Protocols

protocol TaskPageUseCaseProtocol {
    func addTaskPage(title: String) -> TaskPageLocal?
    func togglePageSelection(page: TaskPageLocal) -> [TaskPageLocal]
    func removePages(with uuid: UUID) -> Int?
    func fetchAllPages() -> [TaskPageLocal]
}

protocol TaskUseCaseProtocol {
    func addTask(with title: String, idTaskPage: UUID) -> TasksLocal?
    func toggleTaskCompletion(task: TasksLocal) -> [TasksLocal]
    func removeTask(at index: IndexSet) -> Int?
    func removeTasks(tasks: [TasksLocal]) -> [TasksLocal]
    func updateTask(task: TasksLocal)
    func fetchAllTask() -> [TasksLocal]
}

protocol TagUseCaseProtocol {
    func addTag(withTitle title: String, idTaskItem: UUID) -> TagLocal?
    func removeOneTag(withId id: UUID) -> Int?
    func removeAllTag(tag: [TagLocal]) -> [TagLocal]
    func updateTag(tag: TagLocal)
    func fetchAllTags() -> [TagLocal]
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
