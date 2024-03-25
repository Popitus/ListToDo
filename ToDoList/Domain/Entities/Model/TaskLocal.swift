import Foundation

struct TasksLocal: Identifiable, Equatable {
    
    var id = UUID()
    var title: String
    var date: Date
    var status: TodoStatus
    var note: String
    var lastUpdate: Date
    var completed = false
    var tag: [TagLocal]
        
    init(id: UUID = UUID(), title: String, date: Date, status: TodoStatus, note: String, lastUpdate: Date, completed: Bool = false, taskPageItemID: UUID? = nil, tag: [TagLocal] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.note = note
        self.lastUpdate = lastUpdate
        self.completed = completed
        self.taskPageItemID = taskPageItemID
        self.tag = tag
    }
    
    var taskPageItemID: UUID?
    
    var printObject: String {
        return "id: \(self.id), title: \(self.title), date: \(self.date), note: \(self.note), lastUpdate: \(self.lastUpdate), completed: \(self.completed), taskPageItemId: \(taskPageItemID)"
    }

}
