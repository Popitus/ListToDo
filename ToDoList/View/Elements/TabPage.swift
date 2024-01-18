import SwiftUI

struct TabPage: View {
        
    //Properties
    @State private var isTapped = false
    var title: String
    var toggleSelectedPage: () -> Void
    var toggleDeletedPage: () -> Void
    
    var body: some View {
        
        Text("\(title)")
            .frame(width: .infinity)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .onTapGesture {
                isTapped.toggle()
                toggleSelectedPage()
            }
            .gesture(LongPressGesture().onEnded({ _ in
                toggleDeletedPage()
            }))
            
            .background(isTapped ? .blue : .gray)
            .clipShape(Capsule())
    }
}

#Preview {
    TabPage(title: "Texto", toggleSelectedPage: {}, toggleDeletedPage: {})
}
