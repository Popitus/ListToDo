@testable import ToDoList
import Foundation

var pages: [TaskPageItem] = []

struct TaskPageUseCaseMock: TaskPageUseCaseProtocol {
    
    func addTaskPage(title: String) -> [TaskPageItem] {
        let newPage = TaskPageItem(title: title)
        pages.append(newPage)
        return pages
    }
    
    func togglePageSelection(page: ToDoList.TaskPageItem) {
        guard let index = pages.firstIndex(where: { $0.id == page.id }) else {
            return
        }
        pages[index].selected.toggle()
        pages.indices
            .filter { $0 != index }
            .forEach { pages[$0].selected = false }
    }
    
    func removePages(with uuid: UUID) -> [TaskPageItem] {
        if let index = pages.firstIndex(where: {$0.id == uuid}) {
            pages.remove(at: index)
        }
        return pages
    }

}
