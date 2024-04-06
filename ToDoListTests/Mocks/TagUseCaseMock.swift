import Foundation
@testable import ToDoList

var tagMock: [TagItem] = []

struct TagUseCaseMock: TagUseCaseProtocol {
    func addTag(withTitle title: String, idTaskItem: UUID) -> TagLocal? {
        let tasks = taskMock
        var checkTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if let index = tasks.firstIndex(where: { $0.id == idTaskItem }) {
            if !checkTitle.isEmpty {
                if checkTitle.last == "," { checkTitle.removeLast() }
                let newTag = TagLocal(id: UUID(), title: checkTitle, taskItemID: tasks[index].id)
                tasks[index].lastUpdate = Date()
                tagMock.append(TagMapper.mapToData(tagLocal: newTag))
                return newTag
            }
        }
        return nil
    }

    func removeOneTag(withId id: UUID) -> Int? {
        if let index = tagMock.firstIndex(where: { $0.id == id }) {
            tagMock.remove(at: index)
            return index
        }
        return nil
    }

    func removeAllTag(tag _: [TagLocal]) -> [TagLocal] {
        tagMock = []
        return tagMock.map { TagMapper.mapToDomain(tagItem: $0) }
    }

    func fetchAllTags() -> [TagLocal] {
        return tagMock.map { TagMapper.mapToDomain(tagItem: $0) }
    }
}
