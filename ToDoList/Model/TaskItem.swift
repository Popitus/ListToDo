
import Foundation
import SwiftData

@Model
final class TaskItem {
    @Attribute(.unique) var id = UUID()
    var title: String
    var date: Date
    var status: TodoStatus
    var completed = false
    
    init(id: UUID = UUID(), title: String, date: Date, status: TodoStatus, completed: Bool = false) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.completed = completed
    }
}
