import SwiftUI

enum TodoStatus: String, Codable {
    case pending
    case inProcess
    case completed
}

extension TodoStatus {
    static func colorStyle(_ status: TodoStatus) -> Color {
        switch status {
        case .pending: Color.orange
        case .inProcess: Color.yellow
        case .completed: Color.green
        }
    }
}
