
import SwiftUI

struct AddTaskView: View {
    
    @Binding var newTaskTitle: String
    var addAdction: () -> Void
    
    var body: some View {
        HStack {
            TextField("new_task", text: $newTaskTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityIdentifier("title_add_new_task")
            
            Button(action: {
                addAdction()
                newTaskTitle = ""
            }, label: {
                Text("button_add")
                    .accessibilityIdentifier("button_add_new_task")
            })
        }
    }
}

#Preview {
    @State var newTaskTitle: String = ""
    return AddTaskView(newTaskTitle: $newTaskTitle, addAdction: {})
}
