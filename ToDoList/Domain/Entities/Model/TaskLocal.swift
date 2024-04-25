import Foundation

struct TasksLocal: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var date: Date
    var status: TodoStatus
    var note: String
    var lastUpdate: Date
    var completed = false
    var sticker: Sticker
    var tag: [TagLocal]
   

    init(id: UUID = UUID(), title: String, date: Date, status: TodoStatus, note: String, lastUpdate: Date, completed: Bool = false, sticker: Sticker, taskPageItemID: UUID? = nil, tag: [TagLocal] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.note = note
        self.lastUpdate = lastUpdate
        self.completed = completed
        self.sticker = sticker
        self.taskPageItemID = taskPageItemID
        self.tag = tag
    }

    var taskPageItemID: UUID?

    var printObject: String {
        return "id: \(id), title: \(title), date: \(date), note: \(note), lastUpdate: \(lastUpdate), completed: \(completed), sticker:\(sticker.name), taskPageItemId: \(taskPageItemID)"
    }
}
