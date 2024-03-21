@testable import ToDoList
import Foundation

var tagMock: [TagItem] = []

struct TagUseCaseMock: TagUseCaseProtocol {
    
    func addTag(withTitle title: String, idTaskItem: UUID) -> TagItem? {
        let tasks = taskMock
        let checkTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if let index = tasks.firstIndex(where: { $0.id == idTaskItem }) {
            if !checkTitle.isEmpty {
                let newTag = TagItem(id: UUID(), title: title, taskItem: tasks[index])
               // tasks[index].tag.append(newTag)
                tasks[index].lastUpdate = Date()
                tagMock.append(newTag)
                return newTag
            }
        }
        return nil
    }
    
    func removeOneTag(withId id: UUID) -> Int? {
        if let index = tagMock.firstIndex(where: {$0.id == id}) {
            tagMock.remove(at: index)
            return index
        }
        return nil
    }
    
    func removeAllTag(tag: [TagItem]) -> [TagItem] {
        tagMock = []
        return tagMock
    }
    
    func fetchAllTags() -> [TagItem] {
        return tagMock
    }
    
    
}
