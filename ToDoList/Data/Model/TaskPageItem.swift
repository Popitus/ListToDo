
import Foundation
import SwiftData

@Model
final class TaskPageItem {
    
    // Properties
    @Attribute(.unique) var id = UUID()
    var title: String
    var selected = false
    
    // Relantionship
    @Relationship(deleteRule: .cascade, inverse: \TaskItem.taskPageItem)
    var tasksItems: [TaskItem]?
    
    init(id: UUID = UUID(), title: String, selected: Bool = false) {
        self.id = id
        self.title = title
        self.selected = selected
    }
    
    @Attribute(.ephemeral)
    var printObject: String {
        return "id: \(self.id), title: \(self.title), selected: \(self.selected), taskItems: \(String(describing: self.tasksItems))"
    }
}
