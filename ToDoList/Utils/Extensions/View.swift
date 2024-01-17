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
}
