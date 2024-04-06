import SwiftUI

class CustomTagTextField: UITextField {
    open var onBackPressed: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func deleteBackward() {
        onBackPressed?()
        super.deleteBackward()
    }

    override func canPerformAction(_: Selector, withSender _: Any?) -> Bool {
        return false
    }
}
