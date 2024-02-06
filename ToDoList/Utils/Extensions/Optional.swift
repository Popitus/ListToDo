import SwiftUI

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

extension Binding {
    func withDefault<Wrapped>(value defaultValue: Wrapped) -> Binding<Wrapped> where Optional<Wrapped> == Value {
        Binding<Wrapped> {
            wrappedValue ?? defaultValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }
}
