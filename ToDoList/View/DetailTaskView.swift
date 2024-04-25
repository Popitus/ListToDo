
import SwiftUI

struct DetailTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel
    
    @State private var taskTitle: String = "Titulo..."
    @State private var taskNote: String = "Añadir Nota..."
    @State private var titleTag: String = ""
    
    @State var task: TasksLocal
    @State var localTags: [TagLocal]
    @State var originalTask: TasksLocal? = nil
    var body: some View {
        VStack{
            List {
                Section("section_title") {
                    CustomTextField(
                        placeholder: taskTitle,
                        text: $task.title,
                        onEditingChanged: { _ in
                        })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section("section_tags") {
                    TagField(tags: $localTags)
                        .onChange(of: localTags) { newTag, oldTag in
                            if let tag = newTag.last, oldTag.last != nil {
                                if newTag.count < oldTag.count {
                                    taskViewModel.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)
                                } else if newTag.count > oldTag.count {
                                    taskViewModel.removeOneTag(id: oldTag.last?.id ?? UUID())
                                }
                            }
                            if let lastIndex = localTags.indices.last, lastIndex > 0, localTags[lastIndex].title == "" {
                                taskViewModel.updateTag(tag: localTags[lastIndex - 1])
                            }
                        }
                }
                
                Section("section_note") {
                    ZStack {
                        TextEditor(text: $task.note)
                            .frame(height: 125)
                        if task.note.isEmpty {
                            VStack {
                                HStack {
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
            Button {
                taskViewModel.toggleTaskStatus(task: task)
            } label: {
                StatusIndicator(status: task.status)
            }
        }
        .background(TodoStatus.colorStyle(task.status).opacity(0.20))
        .scrollContentBackground(.hidden)
        
        .onAppear {
            originalTask = task
        }
        .onChange(of: task) {
            taskViewModel.updateTitleAndNote(with: task)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(String(localized: "cancel"),
                       role: .destructive,
                       action: {
                    if let originalTask {
                        task = originalTask
                        dismiss()
                    }
                })
                    .buttonStyle(.borderedProminent)
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack{
                Divider()
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
            }
            .background(.thinMaterial)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("\(task.title)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    let tags = [TagLocal(title: "Tag1"), TagLocal(title: "Tag2")]
    let task = TasksLocal(title: "Prueba", date: Date.now, status: .pending, note: "Prueba de nota", lastUpdate: Date())
    
    return NavigationView {
        DetailTaskView(task: task, localTags: tags)
            .environment(taskViewModel)
    }
}

