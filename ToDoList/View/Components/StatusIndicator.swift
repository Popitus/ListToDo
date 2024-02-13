import SwiftUI

struct StatusIndicator: View {
    
    var status: TodoStatus

    var body: some View {
        let backgroundColor: Color = {
                        switch status {
                        case .completed:
                            return Color.green
                        case .pending:
                            return Color.orange
                        }
                    }()

        Text(status == .completed ? String(localized:"status_completed"): String(localized:"status_pending"))
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

#Preview {
    StatusIndicator(status: TodoStatus.pending)
}
