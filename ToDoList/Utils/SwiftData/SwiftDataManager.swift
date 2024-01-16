import Foundation
import SwiftData

final class SwiftDataManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataManager()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: TaskItem.self)
        self.modelContext = modelContainer.mainContext
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
