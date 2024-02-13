import Foundation

extension String {

    private func createFormatter() -> DateFormatter {

        let formatter = DateFormatter()
        formatter.locale =  .autoupdatingCurrent
        formatter.dateFormat = "HH:mm - dd/MM/yyyy"

        return formatter
    }

    func formatDate() -> String {
        let formatter = createFormatter()
        if let date = formatter.date(from: self) {
            return date.format()
        }

        return ""
    }

    func toDate() -> Date {
        let formatter = createFormatter()
        if let date = formatter.date(from: self) {
            return date
        }

        return Date()
    }
    
    func localized() -> String {
        return localized(withComment: "")
    }
    
    func localized(withComment: String) -> String {
        var localized = Bundle.main.localizedString(forKey: self, value: withComment, table: "Localizable")
        if localized == self {
            localized = Bundle.main.localizedString(forKey: self, value: withComment, table: nil)
        }
        return localized
    }

}
