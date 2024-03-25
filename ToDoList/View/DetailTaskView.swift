
import SwiftUI

struct DetailTaskView: View {
    // State properties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var taskTitle: String = "Titulo..."
    @State private var taskNote: String = "Añadir Nota..."
    @State private var titleTag: String = ""
    
    @FocusState private var focused: Bool
    @State var task: TasksLocal
    @State var localTags: [TagLocal]
    
    
    var body: some View {
        List {
            Section("section_title") {
                CustomTextField(placeholder: taskTitle, text: $task.title, onEditingChanged: { _ in
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            
            Section("section_tags") {
                TagField(tags: $localTags)
                    .onChange(of: localTags) { newTag, oldTag in
                        if let tag = newTag.last, (oldTag.last != nil) {
                            if newTag.count < oldTag.count {
                                taskViewModel.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)
                            } else {
                                taskViewModel.removeOneTag(id: oldTag.last?.id ?? UUID())
                            }
                        }
                }
            }
            
            Section("section_status") {
                StatusIndicator(status: task.status)
                    
            }
            .listRowBackground(Color.clear)
            
            Section("section_note") {
                ZStack {
                    TextEditor(text: $task.note)
                        .frame(height: 125)
                    if task.note.isEmpty {
                        VStack{
                            HStack{
                                Text(taskNote)
                                    .foregroundStyle(.tertiary)
                                    .padding(.top, 16)
                                    .padding(.leading, 5)
                                
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
                
            }
        }
        HStack {
            VStack {
                Section("section_createAt") {
                    Text(task.date.format())
                        .font(.footnote)
                }
                .font(.subheadline)
                .padding(.horizontal, 25)
            }
            VStack {
                Section("section_changeAt") {
                    Text(task.lastUpdate.format())
                        .font(.footnote)
                }
                .font(.subheadline)
                .padding(.horizontal, 25)
            }
        }
       
        .listRowBackground(Color.clear)
        .scrollIndicators(.hidden)
        .navigationTitle("\(task.title)")
        .navigationBarTitleDisplayMode(.inline)
      
        
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    let tags = [TagLocal(title: "Tag1"), TagLocal(title: "Tag2")]
    let task = TasksLocal(title: "Prueba", date: Date.now, status: .pending, note: "Prueba de nota", lastUpdate: Date())
    
    return DetailTaskView(task: task, localTags: tags)
        .environment(taskViewModel)
}
