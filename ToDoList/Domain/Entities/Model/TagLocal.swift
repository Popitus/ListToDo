import Foundation

struct TagLocal: Identifiable,Equatable {
    
    // Properties
    var id = UUID()
    var title: String
    var isInitial = false
    var date = Date()
    
    init(id: UUID = UUID(), title: String, isInitial: Bool = false, date: Date = Date(), taskItemID: UUID? = nil) {
        self.id = id
        self.title = title
        self.isInitial = isInitial
        self.date = date
        self.taskItemID = taskItemID
    }
    
    var taskItemID: UUID?
}
