import SwiftUI

struct BackSpaceListnerTextField: UIViewRepresentable {
    var hint: String = "Tag"
    @Binding var text: String
    var onBackPressed: () -> Void

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> CustomTagTextField {
        let textField = CustomTagTextField()
        textField.delegate = context.coordinator
        textField.onBackPressed = onBackPressed
        textField.placeholder = hint
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.backgroundColor = .clear
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textChange(textField:)),
            for: .editingChanged
        )
        return textField
    }

    func updateUIView(_ uiView: CustomTagTextField, context _: Context) {
        uiView.text = text
    }

    func sizeThatFits(_: ProposedViewSize, uiView: CustomTagTextField, context _: Context) -> CGSize? {
        return uiView.intrinsicContentSize
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }

        @objc
        func textChange(textField: UITextField) {
            text = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        }
    }
}
