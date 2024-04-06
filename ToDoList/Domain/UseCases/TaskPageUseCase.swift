import Foundation

class TaskPageUseCase: TaskPageUseCaseProtocol {
    private let swiftDataManager: SwiftDataManagerProtocol

    init(swiftDataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }

    func addTaskPage(title: String) -> TaskPageLocal? {
        if !title.isEmpty {
            let newTaskPage = TaskPageItem(title: title, taskItems: [])
            swiftDataManager.addTaskPageItem(item: newTaskPage)
            return TaskPageMapper.mapToDomain(taskPageItem: newTaskPage)
        }
        return nil
    }

    func togglePageSelection(page: TaskPageLocal) -> [TaskPageLocal] {
        let pages = swiftDataManager.fetchTaskPageItem()
        guard let index = pages.firstIndex(where: { $0.id == page.id }) else {
            return pages.map { TaskPageMapper.mapToDomain(taskPageItem: $0) }
        }
        pages[index].selected.toggle()
        pages.indices
            .filter { $0 != index }
            .forEach { pages[$0].selected = false }

        return pages.map { TaskPageMapper.mapToDomain(taskPageItem: $0) }
    }

    func removePages(with uuid: UUID) -> Int? {
        let pages = swiftDataManager.fetchTaskPageItem()
        if let index = pages.firstIndex(where: { $0.id == uuid }) {
            swiftDataManager.removeTaskPageItem(id: pages[index].id)
            return index
        }
        return nil
    }

    func fetchAllPages() -> [TaskPageLocal] {
        let pagesSw = swiftDataManager.fetchTaskPageItem().map { TaskPageMapper.mapToDomain(taskPageItem: $0) }
        return pagesSw
    }
}
