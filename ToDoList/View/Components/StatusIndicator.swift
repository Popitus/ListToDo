import SwiftUI

struct StatusIndicator: View {
    var status: TodoStatus
    
    var body: some View {
        let (backgroundColor,title): (Color, String) = {
            switch status {
            case .completed:
                (Color.green,String(localized: "status_completed"))
            case .inProcess:
                (Color.yellow,String(localized: "status_inprocess"))
            case .pending:
                (Color.orange,String(localized: "status_pending"))
            }
        }()
        
        Text(title)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

#Preview {
    VStack {
        StatusIndicator(status: TodoStatus.pending)
        StatusIndicator(status: TodoStatus.inProcess)
        StatusIndicator(status: TodoStatus.completed)
    }
}
