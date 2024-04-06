import SwiftUI

struct TabPage: View {
    // Properties
    var page: TaskPageLocal
    var toggleSelectedPage: () -> Void
    var toggleDeletedPage: () -> Void

    var body: some View {
        Text("\(page.title)")
            .frame(maxWidth: .infinity)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .onTapGesture {
                toggleSelectedPage()
            }
            .gesture(LongPressGesture().onEnded { _ in
                toggleDeletedPage()
            })

            .background(page.selected ? .blue : .gray)
            .clipShape(Capsule())
            .accessibilityIdentifier("tap_page_title")
    }
}

#Preview {
    TabPage(page: TaskPageLocal(title: "Test"), toggleSelectedPage: {}, toggleDeletedPage: {})
}
