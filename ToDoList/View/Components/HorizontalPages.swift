import SwiftUI

struct HorizontalPages: View {
    // Properties
    var pages: [TaskPageItem] = []
    var toggleCompletionAddPage: () -> Void
    var toggleSelectedPage: (String) -> Void
    var toggleDeletedPage: (UUID) -> Void


    
    var body: some View {
        VStack {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        if pages.isEmpty {
                            AddPage().onTapGesture { toggleCompletionAddPage() }
                        } else {
                            ForEach(pages) { page in
                                TabPage(
                                    title: page.title,
                                    toggleSelectedPage: { toggleSelectedPage(page.title) },
                                    toggleDeletedPage: { toggleDeletedPage(page.id) })
                            }
                            AddPage().onTapGesture { toggleCompletionAddPage() }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let preview = PreviewSwiftdata([TaskPageItem.self])
    return HorizontalPages(pages:
                            [TaskPageItem(title: "Corto"),
                             TaskPageItem(title: "Largo - 1"),
                             TaskPageItem(title: "Largisimos - 2")],
                           toggleCompletionAddPage: {},
                           toggleSelectedPage: { _ in },
                           toggleDeletedPage: { _ in }
    )
    .modelContainer(preview.container)
    
}
