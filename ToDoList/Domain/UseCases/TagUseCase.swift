import Foundation

class TagUseCase: TagUseCaseProtocol {
    
    private let swiftDataManager: SwiftDataManagerProtocol
    
    init(swiftDataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTag(withTitle title: String, idTaskItem: UUID) -> TagItem? {
        let tasks = swiftDataManager.fetchTaskItem()
        let checkTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if let index = tasks.firstIndex(where: {$0.id == idTaskItem}) {
            if !checkTitle.isEmpty {
                let newTag = TagItem(id: UUID(), title: title, taskItem: tasks[index])
                tasks[index].tag.append(newTag)
                tasks[index].lastUpdate = Date()
                swiftDataManager.addTagToTask(tag: newTag)
                return newTag
                
            }
        }
        return nil
    }
    
    func removeOneTag(withId id: UUID) -> Int? {
        let tags = fetchAllTags()
        if let index = tags.firstIndex(where: {$0.id == id}) {
            swiftDataManager.removeTagTask(id: tags[index].id)
            return index
        }
        return nil
    }
    
    func removeAllTag(tag: [TagItem]) -> [TagItem] {
        for tags in tag {
            swiftDataManager.removeTagTask(id: tags.id)
        }
        return fetchAllTags()
    }
    
    func fetchAllTags() -> [TagItem] {
        return swiftDataManager.fetchTags()
    }
}
