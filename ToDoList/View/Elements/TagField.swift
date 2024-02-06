import SwiftUI

struct TagField: View {
    @Binding var tags: [Tag]
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
        .padding(.horizontal, 15)
        .background(.bar, in: .rect(cornerRadius: 12))
        .onAppear {
            if tags.isEmpty {
                tags.append(.init(title: "", isInitial: true))
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification), perform: { _ in
            if let lastTag = tags.last, !lastTag.title.isEmpty {
                tags.append(.init(title: "", isInitial: true))
            }
        })
       
    }
}

#Preview {
    let preview = PreviewSwiftdata([Tag.self])
    @State var simpleTag = Tag(title: "")
    @State var arrayOfTag = [simpleTag]

    return TagField(
    tags: $arrayOfTag)
        .modelContainer(preview.container)
}
