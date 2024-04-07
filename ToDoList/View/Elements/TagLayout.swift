

import SwiftUI

struct TagLayout: Layout {
    // Properties
    var alignment: Alignment = .center
    var spacing: CGFloat = 10

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? 0
        var height: CGFloat = 0
        let rows = generateRows(maxWidth, proposal, subviews)

        for (index, row) in rows.enumerated() {
            if index == (rows.count - 1) {
                height += row.maxHeight(proposal)
            } else {
                height += row.maxHeight(proposal) + spacing
            }
        }
        return .init(width: maxWidth, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        var origin = bounds.origin
        let maxWidth = bounds.width
        let rows = generateRows(maxWidth, proposal, subviews)

        for row in rows {
            let leading: CGFloat = bounds.maxX - maxWidth
            let trailing = bounds.maxX - (row.reduce(CGFloat.zero) { partialResult, view in
                let widht = view.sizeThatFits(proposal).width
                if view == row.last {
                    return partialResult + widht
                }
                return partialResult + widht + spacing
            })
            let center = (trailing + leading) / 2
            // Reset Coord X
            origin.x = (alignment == .leading ? leading : alignment == .trailing ? trailing : center)

            for view in row {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                // Update coord X
                origin.x += (viewSize.width + spacing)
            }
            // Update coord Y
            origin.y += (row.maxHeight(proposal) + spacing)
        }
    }

    // Rows based on available size of layout
    func generateRows(_ maxWidht: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {
        // Properties
        var row: [LayoutSubviews.Element] = []
        var rows: [[LayoutSubviews.Element]] = []
        var origin = CGRect.zero.origin

        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)

            // new row
            if (origin.x + viewSize.width + spacing) > maxWidht {
                rows.append(row)
                row.removeAll()

                // Resetting Coord X
                origin.x = 0
                row.append(view)

                // Updating Coord X
                origin.x += (viewSize.width + spacing)
            } else {
                // Add item to row
                row.append(view)
                // update Coord Origin x
                origin.x += (viewSize.width + spacing)
            }
        }

        // Check
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }

        return rows
    }
}
