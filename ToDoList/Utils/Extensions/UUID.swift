import Foundation

extension UUID {
    func toInt64() -> Int64 {
        let uuidString = self.uuidString
        let hashValue = uuidString.hashValue
        return Int64(hashValue)
    }
}
