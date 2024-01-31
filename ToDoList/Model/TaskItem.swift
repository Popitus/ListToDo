
import Foundation
import SwiftData

@Model
final class TaskItem:Hashable {
    @Attribute(.unique) var id = UUID()
    var title: String
    var date: Date
    var status: TodoStatus
    var note: String
    var completed = false
    
    @Relationship(deleteRule: .cascade, inverse: \Tag.taskItem)
    var tag: [Tag]?
        
    init(id: UUID = UUID(), title: String, date: Date, status: TodoStatus, note: String, completed: Bool = false) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.note = note
        self.completed = completed
    }
    
    var taskPageItem: TaskPageItem?
}
