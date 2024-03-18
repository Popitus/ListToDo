import Foundation

class TaskPageUseCase: TaskPageUseCaseProtocol {
    
    private let swiftDataManager: SwiftDataManagerProtocol
    
    init(swiftDataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTaskPage(title: String) -> TaskPageItem? {
        if !title.isEmpty {
            let newTaskPage = TaskPageItem(title: title, taskItems: [])
            swiftDataManager.addTaskPageItem(item: newTaskPage)
            return newTaskPage
        }
        return nil
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
    
    func removePages(with uuid: UUID) -> Int? {
        let pages = swiftDataManager.fetchTaskPageItem()
        if let index = pages.firstIndex(where: {$0.id == uuid}) {
            swiftDataManager.removeTaskPageItem(id: pages[index].id)
            return index
        }
        return nil
    }
    
    func fetchAllPages() -> [TaskPageItem] {
        return swiftDataManager.fetchTaskPageItem()
    }
}

