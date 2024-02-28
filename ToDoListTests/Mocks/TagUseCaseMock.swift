@testable import ToDoList
import Foundation

var tagMock: [Tag] = []

struct TagUseCaseMock: TagUseCaseProtocol {
    
    func addTag(addTag: Tag, idTaskItem: UUID) -> [Tag] {
        let tasks = taskMock
        if let index = tasks.firstIndex(where: { $0.id == idTaskItem }) {
            if !addTag.title.isEmpty {
                addTag.taskItem = tasks[index]
                tagMock.append(addTag)
            } else {
               let _ = removeOneTag(tag: addTag)
            }
            tasks[index].lastUpdate = Date()
        }
        return tagMock
    }
    
    func removeOneTag(tag: Tag) -> [Tag] {
        if let index = tagMock.firstIndex(where: {$0.id == tag.id}) {
            tagMock.remove(at: index)
        }
        return tagMock
    }
    
    func removeAllTag(tag: [Tag]) -> [Tag] {
        tagMock = []
        return tagMock
    }
    
    func fetchAllTags() -> [Tag] {
        return tagMock
    }
    
    
}
