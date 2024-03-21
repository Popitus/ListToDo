import SwiftUI

struct TagField: View {
    @Binding var tags: [TagItem]
    @State private var focus: Bool = false
    
    var body: some View {
        TagLayout(alignment: .leading) {
            ForEach($tags) { $tag in
                TagsView(tag: $tag, allTags: $tags)
                    .onChange(of: tag.title) { oldValue, newValue in
                        if newValue.last == "," {
                            tag.title.removeLast()
                            if !tag.title.isEmpty {
                                tags.append(.init(title: ""))
                            }
                        }
                    }
            }
        }
        .clipped()
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .onAppear {
            if tags.isEmpty {
                tags.append(.init(title: "", isInitial: true))
            }
            focus.toggle()
        }
        .onDisappear {
            focus.toggle()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification), perform: { _ in
            if let lastTag = tags.last, focus {
                if !lastTag.title.isEmpty {
                    tags.append(.init(title: "", isInitial: true))
                }
               
            }
        })
       
    }
}

#Preview {
    let preview = PreviewSwiftdata([TagItem.self])
    @State var simpleTag = TagItem(title: "")
    @State var arrayOfTag = [simpleTag]

    return TagField(
    tags: $arrayOfTag)
        .modelContainer(preview.container)
}
