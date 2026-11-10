import SwiftUI

extension View {
    /// The warm brand background behind a grouped list, in place of the
    /// system grey; rows use `AppColors.card`.
    func appListBackground() -> some View {
        scrollContentBackground(.hidden)
            .background(AppColors.surface)
    }
}
