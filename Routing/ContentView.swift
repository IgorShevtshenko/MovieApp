import Combine
import SwiftUI

public struct ContentView<
    Renderer: ViewStateRenderer,
    ViewStateObject: PublishedViewState
>: View where Renderer.ViewState == ViewStateObject.ViewState {
    private let renderer: Renderer
    private let routing: CommittingRouter<Renderer.RoutingDirection>

    @ObservedObject private var viewState: ViewStateObject

    private let onCommitActiveDirections: ([Renderer.RoutingDirection]) -> Void

    public init(
        renderer: Renderer,
        routing: AnyRouting<Renderer.RoutingDirection>,
        viewState: ViewStateObject,
        onCommitActiveDirections: @escaping ([Renderer.RoutingDirection]) -> Void
    ) {
        self.renderer = renderer
        self.routing = CommittingRouter(makeContent: routing.routing)
        self.viewState = viewState
        self.onCommitActiveDirections = onCommitActiveDirections
    }

    public var body: some View {
        routing.begin()
        defer { onCommitActiveDirections(routing.commit()) }
        return renderer.render(state: viewState.viewState, router: AnyRouting(routing: routing))
    }
}

private class CommittingRouter<Direction: Hashable>: Routing {
    private let _makeContent: (Direction) -> AnyView
    private var activeRoutes: [Direction] = []

    init(makeContent: @escaping (Direction) -> AnyView) {
        _makeContent = makeContent
    }

    func routing(for direction: Direction) -> AnyView {
        activeRoutes.append(direction)
        return _makeContent(direction)
    }

    func begin() { activeRoutes = [] }

    func commit() -> [Direction] {
        let routes = activeRoutes
        activeRoutes = []
        return routes
    }
}
