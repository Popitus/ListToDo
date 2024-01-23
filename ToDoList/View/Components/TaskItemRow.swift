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
        }
    }
}		

#Preview {
    let preview = PreviewSwiftdata([TaskItem.self])
    return TaskItemRow(
        task: TaskItem(title: "Test", date: Date(), status: .pending))
    .modelContainer(preview.container)
}
