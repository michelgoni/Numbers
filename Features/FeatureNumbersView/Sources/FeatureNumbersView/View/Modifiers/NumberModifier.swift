import SwiftUI

private extension CGFloat {
    static let padding = 15.0
}

struct NumberModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.padding)
            .background(.red)
            .clipShape(Circle())
    }
}
