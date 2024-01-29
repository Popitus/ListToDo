
import SwiftUI

struct DetailTaskView: View {
    // State properties
    @State private var taskTitle: String = "Titulo..."
    @State private var taskNote: String = "Añadir Nota..."
    @State private var tags: [Tag] = []
    @FocusState private var focused: Bool
    @State var task: TaskItem
  
    
    var body: some View {
        List {
            Section("Título") {
                CustomTextField(placeholder: taskTitle, text: $task.title, onEditingChanged: { _ in
                    
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
               
            }
           
            Section("Tags") {
                TagField(tags: $tags)
            }
            
            Section("Completado?") {
                StatusIndicator(status: task.status)
            }
            
            Section("Notas") {
                TextField(task.note.isEmpty ? "Nota.." :"\(taskNote)", text: $task.note)
            }
        }
        Text("\(task.title)")
        .navigationTitle("\(task.title)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let preview = PreviewSwiftdata([TaskItem.self, Tag.self])

    let task = TaskItem(title: "Prueba", date: Date.now, status: .pending, note: "Prueba de nota")
    
    return DetailTaskView(task: task)
        .modelContainer(preview.container)
}
