
import Foundation
import SwiftData

@Model
final class TaskItem {
    var id = UUID()
    var title: String
    var completed = false
    
    init(id: UUID = UUID(), title: String, completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}
