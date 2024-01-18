import Foundation
import SwiftUI

extension View {
    func roundedBorder(radius: CGFloat, color: Color) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(color, style: StrokeStyle(lineWidth: 0.5))
        )
    }
    
    func printView(_ vars: Any...) -> some View {
            for name in vars { print(name) }
            return EmptyView()
        }
    
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    func alertTextField(
        title: String,
        message: String,
        hintText: String,
        primaryTitle: String,
        secondaryTitle: String,
        primaryAction: @escaping (String) -> (),
        secondaryAction: @escaping () -> ()) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addTextField { field in
                field.placeholder = hintText
            }
            
            alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
                secondaryAction()
            }))
        
            alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
                if let text = alert.textFields?[0].text {
                    primaryAction(text)
                } else {
                    primaryAction("")
                }
            }))
            
            // Presenting Alert
            rootController().present(alert, animated: true, completion: nil)
    }
    
   
}
