@testable import ToDoList
import Foundation

var tagMock: [Tag] = []

struct TagUseCaseMock: TagUseCaseProtocol {
    
    func addTag(addTag: Tag, idTaskItem: UUID) -> [Tag] {
        tagMock.append(addTag)
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
    
    
}
