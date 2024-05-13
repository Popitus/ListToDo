
import SwiftData
import SwiftUI

@main
struct ToDoListApp: App {
    @State var taskViewModel = TaskViewModel()
    // TODO: Review this line to refactor something
    var body: some Scene {
        WindowGroup {
            TaskView()
                .environment(taskViewModel)
        }
    }
}
