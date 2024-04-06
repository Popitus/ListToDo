import SwiftUI

struct TagsView: View {
    // Properties
    @Binding var tag: TagLocal
    @Binding var allTags: [TagLocal]
    @FocusState private var isFocused: Bool

    // View properties
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        BackSpaceListnerTextField(hint: "Tag", text: $tag.title, onBackPressed: { if allTags.count > 1 { if tag.title.isEmpty {
            allTags.removeAll(where: { $0.id == tag.id })
            if let lastIndex = allTags.indices.last {
                allTags[lastIndex].isInitial = false
            }
        }
        }
        })
        .focused($isFocused)
        .padding(.horizontal, isFocused || tag.title.isEmpty ? 0 : 10)
        .padding(.vertical, 10)
        .background((colorScheme == .dark ? Color.black : Color.white)
            .opacity(isFocused || tag.title.isEmpty ? 0 : 1),
            in: .rect(cornerRadius: 5))
        .disabled(tag.isInitial)
        .onChange(of: allTags, initial: true) { _, newValue in
            if newValue.last?.id == tag.id, !(newValue.last?.isInitial ?? false), !isFocused {
                isFocused = true
            }
        }
        .onChange(of: isFocused) { _, _ in
            if !isFocused {
                tag.isInitial = true
            }
        }
        .overlay {
            if tag.isInitial {
                Rectangle()
                    .fill(.clear)
                    .contentShape(.rect)
                    .onTapGesture {
                        if allTags.last?.id == tag.id {
                            tag.isInitial = false
                            isFocused = true
                        }
                    }
            }
        }
    }
}

#Preview {
    let preview = PreviewSwiftdata([TagItem.self])
    @State var simpleTag = TagLocal(title: "test1")
    @State var arrayOfTag = [simpleTag, simpleTag]

    return TagsView(
        tag: $simpleTag,
        allTags: $arrayOfTag
    )
    .modelContainer(preview.container)
}
