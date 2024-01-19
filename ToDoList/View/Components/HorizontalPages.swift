import SwiftUI

struct HorizontalPages: View {
    // Properties
    var pages: [TaskPageItem] = []
    var toggleCompletionAddPage: () -> Void
    var toggleSelectedPage: (TaskPageItem) -> Void
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
                                    page: page,
                                    toggleSelectedPage: { toggleSelectedPage(page) },
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
