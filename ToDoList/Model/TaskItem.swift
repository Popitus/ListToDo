
import Foundation
import SwiftData

@Model
final class TaskItem {
    var title: String
    var date: Date
    var status: TodoStatus
    var completed = false
    
    var taskPageItem: TaskPageItem?
    
    init(title: String, date: Date, status: TodoStatus, completed: Bool = false) {
        self.title = title
        self.date = date
        self.status = status
        self.completed = completed
    }
}
