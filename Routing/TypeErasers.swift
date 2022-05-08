import SwiftUI

public struct AnyRenderer<RoutingDirection: Hashable, ViewState>: ViewStateRenderer {
    private let _render: (ViewState, AnyRouting<RoutingDirection>) -> AnyView

    public init<T: ViewStateRenderer>(
        _ renderer: T
    ) where T.RoutingDirection == RoutingDirection, T.ViewState == ViewState {
        _render = { AnyView(renderer.render(state: $0, router: $1)) }
    }

    public func render(state: ViewState, router: AnyRouting<RoutingDirection>) -> AnyView {
        _render(state, router)
    }
}

public extension ViewStateRenderer {
    func asAny() -> AnyRenderer<RoutingDirection, ViewState> { AnyRenderer(self) }
}

public struct AnyRouting<RoutingDirection: Hashable>: Routing {
    private let _makeSubview: (RoutingDirection) -> AnyView

    public init<T: Routing>(routing: T) where T.RoutingDirection == RoutingDirection {
        _makeSubview = routing.routing
    }

    public init(routing: @escaping (RoutingDirection) -> AnyView) {
        _makeSubview = routing
    }

    public func routing(for direction: RoutingDirection) -> AnyView {
        _makeSubview(direction)
    }
}
