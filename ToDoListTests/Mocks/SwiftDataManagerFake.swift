import Foundation
import SwiftData
@testable import ToDoList

final class SwiftDataManagerFake: SwiftDataManagerProtocol {
    static let shared = SwiftDataManagerFake()

    @MainActor
    var modelContainer: ModelContainer = setupContainer()

    @MainActor
    static func setupContainer() -> ModelContainer {
        do {
            let container = try ModelContainer(for: TaskPageItem.self, TaskItem.self, TagItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
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
            print("Error \(error.localizedDescription)")
        }
    }

    @MainActor
    func fetchTaskItem() -> [TaskItem] {
        do {
            return try modelContainer.mainContext.fetch(FetchDescriptor<TaskItem>(sortBy: [SortDescriptor(\.date)]))
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    @MainActor
    func removeTaskItem(id: UUID) {
        let itemPredicate = #Predicate<TaskItem> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<TaskItem>(predicate: itemPredicate)
        fetchDescriptor.fetchLimit = 1
        do {
            guard let deleteTaskItem = try modelContainer.mainContext.fetch(fetchDescriptor).first else { return }
            modelContainer.mainContext.delete(deleteTaskItem)
            // try modelContainer.mainContext.save()
        } catch {
            print("Error Borrado Task")
        }
    }

    // MARK: TaskPageItems functions

    @MainActor
    func addTaskPageItem(item: TaskPageItem) {
        modelContainer.mainContext.insert(item)
        do {
            try modelContainer.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    @MainActor
    func fetchTaskPageItem() -> [TaskPageItem] {
        do {
            return try modelContainer.mainContext.fetch(FetchDescriptor<TaskPageItem>(sortBy: [SortDescriptor(\.date)]))
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    @MainActor
    func removeTaskPageItem(id: UUID) {
        let itemPredicate = #Predicate<TaskPageItem> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<TaskPageItem>(predicate: itemPredicate)
        fetchDescriptor.fetchLimit = 1
        do {
            guard let deleteTaskPageItem = try modelContainer.mainContext.fetch(fetchDescriptor).first else { return }
            modelContainer.mainContext.delete(deleteTaskPageItem)
            // try modelContainer.mainContext.save()
        } catch {
            print("Error Borrado Page")
        }
    }

    // MARK: Tagsfunctions

    @MainActor
    func addTagToTask(tag: TagItem) {
        modelContainer.mainContext.insert(tag)
        do {
            try modelContainer.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    @MainActor
    func fetchTags() -> [TagItem] {
        do {
            return try modelContainer.mainContext.fetch(FetchDescriptor<TagItem>(sortBy: [SortDescriptor(\.date)]))
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    @MainActor
    func removeTagTask(id: UUID) {
        let itemPredicate = #Predicate<TagItem> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<TagItem>(predicate: itemPredicate)
        fetchDescriptor.fetchLimit = 1
        do {
            guard let deleteTagItem = try modelContainer.mainContext.fetch(fetchDescriptor).first else { return }
            modelContainer.mainContext.delete(deleteTagItem)
            // try modelContainer.mainContext.save()
        } catch {
            print("Error Borrado Tag")
        }
    }
}
