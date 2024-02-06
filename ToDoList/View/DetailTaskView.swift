
import SwiftUI

struct DetailTaskView: View {
    // State properties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var taskTitle: String = "Titulo..."
    @State private var taskNote: String = "Añadir Nota..."
   
    
    @FocusState private var focused: Bool
    @State var task: TaskItem
    @State var localTags: [Tag]
    
    
    var body: some View {
        List {
            Section("Título") {
                CustomTextField(placeholder: taskTitle, text: $task.title, onEditingChanged: { _ in
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            
            Section("Tags") {
                TagField(tags: $localTags)
                    .onChange(of: localTags) { newTag, oldTag in
                        if newTag.count < oldTag.count {
                            taskViewModel.addTag(addTag: newTag.last ?? Tag(title: ""), idTaskItem: task.id)
                        } else {
                            taskViewModel.removeOneTag(tag: oldTag.last ?? Tag(title: ""))
                        }
                    }
            }
            
            Section("Completado?") {
                StatusIndicator(status: task.status)
            }
            
            Section("Notas") {
                TextField(task.note.isEmpty ? "Nota.." :"\(taskNote)", text: $task.note)
                
            }
        }
        Text("\(task.title)")
            .onTapGesture {
                taskViewModel.removeAllTag(tag: localTags)
            }
            .navigationTitle("\(task.title)")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    var tags = [Tag(title: "Tag1"), Tag(title: "Tag2")]
    var task = TaskItem(title: "Prueba", date: Date.now, status: .pending, note: "Prueba de nota")
    
    return DetailTaskView(task: task, localTags: tags)
        .environment(taskViewModel)
}
