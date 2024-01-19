import SwiftUI

struct TabPage: View {
        
    //Properties
    var page: TaskPageItem
    var toggleSelectedPage: () -> Void
    var toggleDeletedPage: () -> Void
    
    var body: some View {
        
        Text("\(page.title)")
            .frame(width: .infinity)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .onTapGesture {
                toggleSelectedPage()
            }
            .gesture(LongPressGesture().onEnded({ _ in
                toggleDeletedPage()
            }))
            
            .background(page.selected ? .blue : .gray)
            .clipShape(Capsule())
    }
}

#Preview {
    let preview = PreviewSwiftdata([TaskPageItem.self])
    return TabPage(page: TaskPageItem(title: "Test"), toggleSelectedPage: {}, toggleDeletedPage: {})
        .modelContainer(preview.container)
}
