
import Foundation
import SwiftData

struct PreviewSwiftdata {
    let container: ModelContainer!

    init(_ types: [any PersistentModel.Type], isStoredInMemoryOnly: Bool = true) {
        let schema = Schema(types)
        let config = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        container = try! ModelContainer(for: schema, configurations: [config])
    }
}
