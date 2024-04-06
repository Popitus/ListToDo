
import SwiftData
import SwiftUI

@main
struct ToDoListApp: App {
    @State var taskViewModel = TaskViewModel()
    var body: some Scene {
        WindowGroup {
            TaskView()
                .environment(taskViewModel)
        }
    }
}
