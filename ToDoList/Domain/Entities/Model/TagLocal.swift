import Foundation

struct TagLocal: Identifiable {
    
    // Properties
    var id = UUID()
    var title: String
    var isInitial = false
    var date = Date()
    
    init(id: UUID = UUID(), title: String, isInitial: Bool = false, date: Date = Date(), taskItem: TasksLocal? = nil) {
        self.id = id
        self.title = title
        self.isInitial = isInitial
        self.date = date
        self.taskItem = taskItem
    
    }
    
    var taskItem: TasksLocal?
}
