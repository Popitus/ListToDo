import SwiftUI

struct TaskItemRow: View {
    
    //Propierties
    var task: TaskItem
    
    var body: some View {
        VStack {
            HStack {
                Text(task.title)
                    .strikethrough(task.completed)
                    .foregroundColor(task.completed ? .gray : .primary)
                    .font(.title3)
                
                Spacer()
                
                StatusIndicator(status: task.status)
            }
            
            HStack {
                Text(task.date.toString())
                    .strikethrough(task.completed)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Spacer()
            }
            HStack {
                if task.tag != [] {
                    Image(systemName: "tag.circle")
                        .padding(.vertical, 4)
                    if let tags = task.tag {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(tags) { tag in
                                    TagsListView(tag: tag.title)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                if !task.note.isEmpty {
                    Spacer()
                    Image(systemName: "text.bubble")
                        .padding(.vertical, 4)
                }
                
            }
            
        }
    }
}		

#Preview {
    let preview = PreviewSwiftdata([TaskItem.self])
    return TaskItemRow(
        task: TaskItem(title: "Test", date: Date(), status: .pending, note: "Prueba de nota"))
    .modelContainer(preview.container)
}
