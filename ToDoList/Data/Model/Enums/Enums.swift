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


enum Sticker: String,Codable,CaseIterable {
    case heart, car, plane, house, work, dog, relax, exercise, none
        
}
extension Sticker {
    var name: String {
        switch self {
        case .none: return String(localized: "sticker_none")
        case .car: return String(localized: "sticker_car")
        case .dog: return String(localized: "sticker_dog")
        case .heart: return String(localized: "sticker_heart")
        case .exercise: return String(localized: "sticker_exercise")
        case .house: return String(localized: "sticker_house")
        case .plane: return String(localized: "sticker_plane")
        case .relax: return String(localized: "sticker_relax")
        case .work: return String(localized: "sticker_work")
        }
    }
    
    var image: Image {
        switch self {
        case .none: return Image(systemName: "rectangle")
        case .car: return Image(systemName: "car")
        case .dog: return Image(systemName: "pawprint")
        case .heart: return Image(systemName: "heart")
        case .exercise: return Image(systemName: "dumbbell")
        case .house: return Image(systemName: "house")
        case .plane: return Image(systemName: "airplane")
        case .relax: return Image(systemName: "figure.mind.and.body")
        case .work: return Image(systemName: "backpack")
        }
    }
    
   // var id:Self { self }
}
