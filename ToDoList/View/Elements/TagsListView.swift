
import SwiftUI

struct TagsListView: View {
    @State var tag: String

    var body: some View {
        Text(tag)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .background(.gray)
            .clipShape(Capsule())
    }
}

#Preview {
    TagsListView(tag: "Prueba")
}
