import Foundation

protocol TagUseCaseProtocol {
    func addTag(addTag: Tag, idTaskItem: UUID)
    func removeOneTag(tag: Tag)
    func removeAllTag(tag: [Tag])
}

class TagUseCase: TagUseCaseProtocol {
    
    private let swiftDataManager: SwiftDataManager
    
    init(swiftDataManager: SwiftDataManager = SwiftDataManager.shared) {
        self.swiftDataManager = swiftDataManager
    }
    
    func addTag(addTag: Tag, idTaskItem: UUID) {
        let tasks = swiftDataManager.fetchTaskItem()
        if let index = tasks.firstIndex(where: {$0.id == idTaskItem }) {
            if !addTag.title.isEmpty {
                addTag.taskItem = tasks[index]
                swiftDataManager.addTagToTask(tag: addTag)
            } else {
                removeOneTag(tag: addTag)
            }
            tasks[index].lastUpdate = Date()
        }
    }
    
    func removeOneTag(tag: Tag) {
        let tags = swiftDataManager.fetchTags()
        if let index = tags.firstIndex(where: {$0.id == tag.id}) {
            swiftDataManager.removeTagTask(tag: tags[index])
        }
    }
    
    func removeAllTag(tag: [Tag]) {
        let tags = swiftDataManager.fetchTags()
        for tags in tags {
            swiftDataManager.removeTagTask(tag: tags)
        }
    }
}
