import Foundation

protocol TaskPageUseCaseProtocol {
    func addTaskPage(title: String)
    func togglePageSelection(page: TaskPageItem)
    func removePages(with uuid: UUID)
}

class TaskPageUseCase: TaskPageUseCaseProtocol {
    
    private let swiftDataManager: SwiftDataManager
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTaskPage(title: String) {
        let newTaskPage = TaskPageItem(title: title)
        swiftDataManager.addTaskPageItem(item: newTaskPage)
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
    
    func removePages(with uuid: UUID) {
        let pages = swiftDataManager.fetchTaskPageItem()
        if let index = pages.firstIndex(where: {$0.id == uuid}) {
            swiftDataManager.removeTaskPageItem(item: pages[index])
        }
    }
}
