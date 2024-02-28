@testable import ToDoList
import Foundation

var pagesMock: [TaskPageItem] = []

struct TaskPageUseCaseMock: TaskPageUseCaseProtocol {
    
    func addTaskPage(title: String) -> [TaskPageItem] {
        let newPage = TaskPageItem(title: title)
        pagesMock.append(newPage)
        return pagesMock
    }
    
    func togglePageSelection(page: TaskPageItem) {
        guard let index = pagesMock.firstIndex(where: { $0.id == page.id }) else {
            return
        }
        pagesMock[index].selected.toggle()
        pagesMock.indices
            .filter { $0 != index }
            .forEach { pagesMock[$0].selected = false }
    }
    
    func removePages(with uuid: UUID) -> [TaskPageItem] {
        if let index = pagesMock.firstIndex(where: {$0.id == uuid}) {
            pagesMock.remove(at: index)
        }
        return pagesMock
    }
    
    func fetchAllPages() -> [TaskPageItem] {
        return pagesMock
    }

}
