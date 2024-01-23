
import Foundation
import SwiftData

@Model
final class TaskItem:Hashable {
    var title: String
    var date: Date
    var status: TodoStatus
    var completed = false
    
    @Relationship(deleteRule: .cascade, inverse: \Tag.taskItem)
    var tag: [Tag]?
        
    init(title: String, date: Date, status: TodoStatus, completed: Bool = false) {
        self.title = title
        self.date = date
        self.status = status
        self.completed = completed
    }
    
    var taskPageItem: TaskPageItem?
}
