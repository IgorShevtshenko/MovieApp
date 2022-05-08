import Foundation
import SwiftUI
import UIKit

public struct CoreRenderer: ViewStateRenderer {
    private let presenter: CorePresenting

    public init(presenter: CorePresenting) {
        self.presenter = presenter
    }

    public func render(
        state _: CoreViewState,
        router _: AnyRouting<Never>
    ) -> some View {
        CoreTabBar(home: AnyView(Color.red), search: AnyView(Color.green), media: AnyView(Color.blue))
    }
}
