import SwiftUI

private extension CGFloat {
    static let padding = 45.0
}

struct NumberModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.system(size: 45, weight: .light))
            .foregroundColor(.white)
            .padding(.padding)
            .background(.red)
            .clipShape(
                Circle()
            )

    }
}
