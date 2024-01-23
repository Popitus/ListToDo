import SwiftUI

struct TagsView: View {
    // Properties
    @Binding var tag: Tag
    @Binding var allTags: [Tag]
    @FocusState private var isFocused: Bool
    
    // View properties
    @Environment(\.colorScheme) private var colorScheme
   
    var body: some View {
        TextField("Tag", text: $tag.title)
            .focused($isFocused)
            .padding([.horizontal, .vertical], 10)
            .background((colorScheme == .dark ? Color.black : Color.white)
                    .opacity(isFocused || tag.title.isEmpty ? 0 : 1),
                in: .rect(cornerRadius: 5))
            .disabled(tag.isInitial)
            .onChange(of: allTags, initial: true, { oldValue, newValue in
                if newValue.last?.id == tag.id && !(newValue.last?.isInitial ?? false) && !isFocused {
                    isFocused = true
                }
            })
            .overlay {
                if tag.isInitial {
                    Rectangle()
                        .fill(.clear)
                        .contentShape(.rect)
                        .onTapGesture {
                            tag.isInitial = false
                            isFocused = true
                        }
                }
            }
    }
}

#Preview {
    let preview = PreviewSwiftdata([Tag.self])
    @State var simpleTag = Tag(title: "test1")
    @State var arrayOfTag = [simpleTag, simpleTag]

    return TagsView(
        tag: $simpleTag,
        allTags: $arrayOfTag)
    .modelContainer(preview.container)
}
