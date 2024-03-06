import Foundation
import SwiftData


final class SwiftDataManager: SwiftDataManagerProtocol {
        
    static let shared = SwiftDataManager()
    
    @MainActor
    var modelContainer: ModelContainer = setupContainer()
    
    @MainActor
    static func setupContainer() -> ModelContainer {
        do {
            let container = try ModelContainer(for: TaskPageItem.self, TaskItem.self, Tag.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    private init() {}
    
    // MARK: TaskItems Functions
    
    @MainActor
    func addTaskItem(item: TaskItem) {
        modelContainer.mainContext.insert(item)
        do {
            try modelContainer.mainContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchTaskItem() -> [TaskItem] {
        do {
            return try modelContainer.mainContext.fetch(FetchDescriptor<TaskItem>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func removeTaskItem(item: TaskItem) {
        do {
            modelContainer.mainContext.delete(item)
            try modelContainer.mainContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: TaskPageItems functions
    @MainActor
    func addTaskPageItem(item: TaskPageItem) {
        modelContainer.mainContext.insert(item)
        do {
            try modelContainer.mainContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchTaskPageItem() -> [TaskPageItem] {
        do {
            return try modelContainer.mainContext.fetch(FetchDescriptor<TaskPageItem>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func removeTaskPageItem(item: TaskPageItem) {
        do {
            modelContainer.mainContext.delete(item)
            try modelContainer.mainContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
       
    }
    
    // MARK: Tagsfunctions
    
    @MainActor
    func addTagToTask(tag: Tag) {
        modelContainer.mainContext.insert(tag)
        do {
            try modelContainer.mainContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchTags() -> [Tag] {
        do {
            return try modelContainer.mainContext.fetch(FetchDescriptor<Tag>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func removeTagTask(tag: Tag) {
        do {
            modelContainer.mainContext.delete(tag)
            try modelContainer.mainContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
