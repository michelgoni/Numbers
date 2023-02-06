import Inject
import SwiftUI

private extension CGFloat {
    static let padding = 45.0
}

struct NumberModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.system(size: 55, weight: .thin))
            .foregroundColor(.white)
            .padding(.padding)
            .background(.red)
            .clipShape(
                Circle()
            )

    }
}
