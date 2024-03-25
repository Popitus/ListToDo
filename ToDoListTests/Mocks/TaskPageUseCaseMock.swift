@testable import ToDoList
import Foundation

var pagesMock: [TaskPageItem] = []

struct TaskPageUseCaseMock: TaskPageUseCaseProtocol {
    
    func addTaskPage(title: String) -> TaskPageLocal? {
        if !title.isEmpty {
            let newPage = TaskPageItem(title: title, taskItems: [])
            pagesMock.append(newPage)
            return TaskPageMapper.mapToDomain(taskPageItem: newPage)
        }
        return nil
    }
    
    func togglePageSelection(page: TaskPageLocal) -> [TaskPageLocal] {
        guard let index = pagesMock.firstIndex(where: { $0.id == page.id }) else {
            return pagesMock.map{TaskPageMapper.mapToDomain(taskPageItem: $0)}
        }
        pagesMock[index].selected.toggle()
        pagesMock.indices
            .filter { $0 != index }
            .forEach { pagesMock[$0].selected = false }
        
        return pagesMock.map{TaskPageMapper.mapToDomain(taskPageItem: $0)}
    }
    
    func removePages(with uuid: UUID) -> Int? {
        if let index = pagesMock.firstIndex(where: {$0.id == uuid}) {
            pagesMock.remove(at: index)
            return index
        }
        return nil
    }
    
    func fetchAllPages() -> [TaskPageLocal] {
        return pagesMock.map{ TaskPageMapper.mapToDomain(taskPageItem: $0) }
    }

}
