import Foundation
import SwiftUI

extension Date {
    func format(_ format: String = "HH:mm - dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.autoupdatingCurrent
        let component = formatter.string(from: self)
        return component
    }
    
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
