import SwiftUI

struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    var onEditingChanged: (Bool) -> Void

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context _: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(parent: CustomTextField) {
            self.parent = parent
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onEditingChanged(true)
            textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)
        }

        func textFieldDidEndEditing(_: UITextField, reason _: UITextField.DidEndEditingReason) {
            parent.onEditingChanged(false)
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let currentText = textField.text else { return true }
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            parent.text = newText
            return true
        }
    }
}
