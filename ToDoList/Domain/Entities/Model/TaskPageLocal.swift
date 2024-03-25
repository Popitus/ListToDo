import Foundation

struct TaskPageLocal: Identifiable, Equatable {
    
    // Properties
    var id = UUID()
    var title: String
    var selected = false
    var date = Date()
    var tasksItems: [TasksLocal]
    
    init(id: UUID = UUID(), title: String, selected: Bool = false, date: Date = Date(),  taskItems: [TasksLocal] = []) {
        self.id = id
        self.title = title
        self.selected = selected
        self.date = date
        self.tasksItems = taskItems
    }
}
