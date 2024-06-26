
import Foundation
import SwiftData

@Model
final class TaskItem {
    @Attribute(.unique) var id = UUID()
    var title: String
    var date: Date
    var status: TodoStatus
    var note: String
    var lastUpdate: Date
    var completed = false

    @Relationship(deleteRule: .cascade, inverse: \TagItem.taskItem) var tag: [TagItem]

    init(id: UUID = UUID(), title: String, date: Date, status: TodoStatus, note: String, lastUpdate: Date, completed: Bool = false, taskPageItem: TaskPageItem? = nil, tag: [TagItem] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.note = note
        self.lastUpdate = lastUpdate
        self.completed = completed
        self.taskPageItem = taskPageItem
        self.tag = tag
    }

    var taskPageItem: TaskPageItem?

    @Attribute(.ephemeral)
    var printObject: String {
        return "id: \(id), title: \(title), date: \(date), note: \(note), lastUpdate: \(lastUpdate), completed: \(completed)"
    }
}
