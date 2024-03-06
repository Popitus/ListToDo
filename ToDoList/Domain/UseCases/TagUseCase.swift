import Foundation

class TagUseCase: TagUseCaseProtocol {
    
    private let swiftDataManager: SwiftDataManagerProtocol
    
    init(swiftDataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTag(withTitle title: String, idTaskItem: UUID, idTag: UUID) -> [Tag] {
        let tasks = swiftDataManager.fetchTaskItem()
        let checkTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if let index = tasks.firstIndex(where: {$0.id == idTaskItem}) {
            if !checkTitle.isEmpty {
                let newTag = Tag(id: idTag, title: title)
                newTag.taskItem = tasks[index]
                tasks[index].lastUpdate = Date()
                swiftDataManager.addTagToTask(tag: newTag)
            }
        }
        return fetchAllTags()
    }
    
    func removeOneTag(withId id: UUID) -> [Tag] {
        let tags = fetchAllTags()
        if let index = tags.firstIndex(where: {$0.id == id}) {
            swiftDataManager.removeTagTask(tag: tags[index])
        }
        return fetchAllTags()
    }
    
    func removeAllTag(tag: [Tag]) -> [Tag] {
        for tags in tag {
            swiftDataManager.removeTagTask(tag: tags)
        }
        return fetchAllTags()
    }
    
    func fetchAllTags() -> [Tag] {
        return swiftDataManager.fetchTags()
    }

}
