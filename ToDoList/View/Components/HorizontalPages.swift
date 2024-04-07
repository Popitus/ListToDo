import SwiftUI

struct HorizontalPages: View {
    
    var pages: [TaskPageLocal] = []
    var toggleCompletionAddPage: () -> Void
    var toggleSelectedPage: (TaskPageLocal) -> Void
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
                                    toggleDeletedPage: { toggleDeletedPage(page.id) }
                                )
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
    HorizontalPages(pages:
        [TaskPageLocal(title: "Corto"),
         TaskPageLocal(title: "Largo - 1"),
         TaskPageLocal(title: "Largisimos - 2")],
        toggleCompletionAddPage: {},
        toggleSelectedPage: { _ in },
        toggleDeletedPage: { _ in })
}
