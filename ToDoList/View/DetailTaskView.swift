
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
            Section("section_title") {
                CustomTextField(placeholder: taskTitle, text: $task.title, onEditingChanged: { _ in
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            
            Section("section_tags") {
                TagField(tags: $localTags)
                    .onChange(of: localTags) { newTag, oldTag in
                        if let _ = newTag.last, (oldTag.last != nil) {
                            if newTag.count < oldTag.count {
                                taskViewModel.addTag(addTag: newTag.last ?? Tag(title: ""), idTaskItem: task.id)
                            } else {
                                taskViewModel.removeOneTag(tag: oldTag.last ?? Tag(title: ""))
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
    let tags = [Tag(title: "Tag1"), Tag(title: "Tag2")]
    let task = TaskItem(title: "Prueba", date: Date.now, status: .pending, note: "Prueba de nota", lastUpdate: Date())
    
    return DetailTaskView(task: task, localTags: tags)
        .environment(taskViewModel)
}
