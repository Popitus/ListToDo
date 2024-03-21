import Foundation

struct TaskLocal: Identifiable {
    
    var id = UUID()
    var title: String
    var date: Date
    var status: TodoStatus
    var note: String
    var lastUpdate: Date
    var completed = false
    var tag: [TagLocal]
        
    init(id: UUID = UUID(), title: String, date: Date, status: TodoStatus, note: String, lastUpdate: Date, completed: Bool = false, taskPageItem: TaskPageLocal? = nil, tag: [TagLocal] = []) {
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
    
    var taskPageItem: TaskPageLocal?

}
