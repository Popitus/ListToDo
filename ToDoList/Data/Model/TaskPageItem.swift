
import Foundation
import SwiftData

@Model
final class TaskPageItem {
    
    // Properties
    @Attribute(.unique) var id = UUID()
    var title: String
    var selected = false
    var date = Date()
    
    // Relantionship
    @Relationship(deleteRule: .cascade, inverse: \TaskItem.taskPageItem) var tasksItems: [TaskItem]
    
    init(id: UUID = UUID(), title: String, selected: Bool = false, date: Date = Date(),  taskItems: [TaskItem] = []) {
        self.id = id
        self.title = title
        self.selected = selected
        self.date = date
        self.tasksItems = taskItems
    }
    
    @Attribute(.ephemeral)
    var printObject: String {
        return "id: \(self.id), title: \(self.title), selected: \(self.selected), taskItems: \(String(describing: self.tasksItems))"
    }
}
