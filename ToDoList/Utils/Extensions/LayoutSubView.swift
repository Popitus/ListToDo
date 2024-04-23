
import SwiftUI

extension [LayoutSubviews.Element] {
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
        return self.compactMap { view in
            view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}
