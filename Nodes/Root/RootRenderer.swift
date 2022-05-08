import Foundation
import SwiftUI
import UIKit

public struct RootRenderer: ViewStateRenderer {
    private let presenter: RootPresenting

    public init(
        presenter: RootPresenting
    ) {
        self.presenter = presenter
        setupTabBar()
    }

    public func render(
        state _: RootViewState,
        router: AnyRouting<RootRouting>
    ) -> some View {
        router.routing(for: .core)
    }

    private func setupTabBar() {
        UITabBar.appearance().isHidden = true
    }
}
