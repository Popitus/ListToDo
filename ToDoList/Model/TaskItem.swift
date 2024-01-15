
import Foundation

struct TaskItem: Identifiable {
    var id = UUID()
    var title: String
    var completed = false
}
