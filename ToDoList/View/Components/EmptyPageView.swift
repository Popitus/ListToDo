
import SwiftUI

struct EmptyPageView: View {
    @State private var animationCount = 0
    
    var body: some View {
        Spacer()
        Image(systemName: "book.pages.fill")
            .symbolEffect(.bounce, value: animationCount)
            .font(.system(size: 100))
            .onTapGesture {
                animationCount += 1
            }
        Text("empty_categories")
        Spacer()
    }
}

#Preview {
    EmptyPageView()
}
