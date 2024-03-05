import Foundation

class TaskPageUseCase: TaskPageUseCaseProtocol {
    
    private let swiftDataManager: SwiftDataManagerProtocol
    
    init(swiftDataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTaskPage(title: String) -> [TaskPageItem]{
        if !title.isEmpty {
            let newTaskPage = TaskPageItem(title: title)
            swiftDataManager.addTaskPageItem(item: newTaskPage)
        }
        return swiftDataManager.fetchTaskPageItem()
    }
    
    func togglePageSelection(page: TaskPageItem) {
        let pages = swiftDataManager.fetchTaskPageItem()
        guard let index = pages.firstIndex(where: { $0.id == page.id }) else {
            return
        }
        pages[index].selected.toggle()
        pages.indices
            .filter { $0 != index }
            .forEach { pages[$0].selected = false }
    }
    
    func removePages(with uuid: UUID) -> [TaskPageItem] {
        let pages = swiftDataManager.fetchTaskPageItem()
        if let index = pages.firstIndex(where: {$0.id == uuid}) {
            swiftDataManager.removeTaskPageItem(item: pages[index])
        }
        return swiftDataManager.fetchTaskPageItem()
    }
    
    func fetchAllPages() -> [TaskPageItem] {
        return swiftDataManager.fetchTaskPageItem()
    }
}

