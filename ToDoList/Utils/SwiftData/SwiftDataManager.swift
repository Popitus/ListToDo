import Foundation
import SwiftData

final class SwiftDataManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataManager()
    
    @MainActor
    init() {
        let schema = Schema([TaskPageItem.self, TaskItem.self, Tag.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.modelContext = modelContainer.mainContext
            print(URL.documentsDirectory.path())
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    // MARK: TaskItems Functions
    
    func addTaskItem(item: TaskItem) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchTaskItem() -> [TaskItem] {
        do {
            return try modelContext.fetch(FetchDescriptor<TaskItem>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeTaskItem(item: TaskItem) {
        modelContext.delete(item)
    }
        
    // MARK: TaskPageItems functions
    
    func addTaskPageItem(item: TaskPageItem) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchTaskPageItem() -> [TaskPageItem] {
        do {
            return try modelContext.fetch(FetchDescriptor<TaskPageItem>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeTaskPageItem(item: TaskPageItem) {
        modelContext.delete(item)
    }

    // MARK: Tagsfunctions
    
    func addTagToTask(tag: Tag) {
        modelContext.insert(tag)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchTags() -> [Tag] {
        do {
            return try modelContext.fetch(FetchDescriptor<Tag>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeTagTask(tag: Tag) {
        modelContext.delete(tag)
    }
    
}
