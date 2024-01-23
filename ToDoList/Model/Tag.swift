
import Foundation
import SwiftData

@Model
final class Tag {
    
    // Properties
    @Attribute(.unique) var id = UUID()
    var title: String
    var isInitial = false
    
    init(id: UUID = UUID(), title: String, isInitial: Bool = false) {
        self.id = id
        self.title = title
        self.isInitial = isInitial
    
    }
    
    var taskItem: TaskItem?
}
