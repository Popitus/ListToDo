import SwiftUI

struct TaskItemRow: View {
    
    var task: TaskItem
    var toggleCompletion: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button(action: toggleCompletion, label: {
                    Image(systemName: task.completed ? "checkmark.square" : "square")
                        .foregroundStyle(task.completed ? .green : .black)
                })
                
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
        }
    }
}		

#Preview {
    let preview = PreviewSwiftdata([TaskItem.self])
    return TaskItemRow(
        task: TaskItem(title: "Test", date: Date(), status: .pending),
        toggleCompletion: {})
    .modelContainer(preview.container)
}
