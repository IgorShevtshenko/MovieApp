import SwiftUI
import Foundation

public struct CoreRenderer: ViewStateRenderer {
    
    private let presenter: CorePresenting
    
    public init(presenter: CorePresenting) {
        self.presenter = presenter
    }
    
    public func render(
        state: CoreViewState,
        router: AnyRouting<CoreRouting>
    ) -> some View {
        CoreTabBar(
            home: router.routing(for: .home),
            media: router.routing(for: .media),
            search: router.routing(for: .search)
        )
    }
}
