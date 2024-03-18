@testable import ToDoList
import Foundation

var tagMock: [Tag] = []

struct TagUseCaseMock: TagUseCaseProtocol {
    
    func addTag(withTitle title: String, idTaskItem: UUID) -> [Tag] {
        let tasks = taskMock
        let checkTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if let index = tasks.firstIndex(where: { $0.id == idTaskItem }) {
            if !checkTitle.isEmpty {
                let newTag = Tag(id: UUID(), title: title)
                newTag.taskItem = tasks[index]
                tasks[index].lastUpdate = Date()
                tagMock.append(newTag)
            }
        }
        return tagMock
    }
    
    func removeOneTag(withId id: UUID) -> [Tag] {
        if let index = tagMock.firstIndex(where: {$0.id == id}) {
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
