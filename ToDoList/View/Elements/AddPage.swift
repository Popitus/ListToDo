
import SwiftUI

struct AddPage: View {
    var body: some View {
        Text("+")
            .frame(width: 30)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .background(.gray)
            .clipShape(Capsule())
            .accessibilityIdentifier("add_title_to_page")
    }
}

#Preview {
    AddPage()
}
