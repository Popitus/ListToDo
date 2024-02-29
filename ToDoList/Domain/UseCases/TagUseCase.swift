import Foundation

protocol TagUseCaseProtocol {
    func addTag(addTag: Tag, idTaskItem: UUID) -> [Tag]
    func removeOneTag(tag: Tag) -> [Tag]
    func removeAllTag(tag: [Tag]) -> [Tag]
    func fetchAllTags() -> [Tag]
}

class TagUseCase: TagUseCaseProtocol {
    
    private let swiftDataManager: SwiftDataManager
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTag(addTag: Tag, idTaskItem: UUID) -> [Tag] {
        let tasks = swiftDataManager.fetchTaskItem()
        if let index = tasks.firstIndex(where: {$0.id == idTaskItem}) {
            addTag.taskItem = tasks[index]
            swiftDataManager.addTagToTask(tag: addTag)
        }
        return swiftDataManager.fetchTags()
    }
    
    func removeOneTag(tag: Tag) -> [Tag] {
        let tags = swiftDataManager.fetchTags()
        if let index = tags.firstIndex(where: {$0.id == tag.id}) {
            swiftDataManager.removeTagTask(tag: tags[index])
        }
        return swiftDataManager.fetchTags()
    }
    
    func removeAllTag(tag: [Tag]) -> [Tag] {
        for tags in tag {
            swiftDataManager.removeTagTask(tag: tags)
        }
        return swiftDataManager.fetchTags()
    }
    
    func fetchAllTags() -> [Tag] {
        return swiftDataManager.fetchTags()
    }

}
