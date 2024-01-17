import Foundation
import SwiftData

final class SwiftDataManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataManager()
    
    @MainActor
    init() {
        let schema = Schema([TaskItem.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.modelContext = modelContainer.mainContext
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
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
}
