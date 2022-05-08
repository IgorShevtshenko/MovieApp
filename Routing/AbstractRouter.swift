import Combine
import SwiftUI

open class AbstractRouter<RoutingDirection: Hashable, ViewState>: Router {
    public typealias ViewState = ViewState

    public var view: AnyView {
        AnyView(
            ContentView(
                renderer: renderer,
                routing: AnyRouting(routing: routing),
                viewState: viewState,
                onCommitActiveDirections: onActiveDirectionsUpdate
            )
        )
    }

    private let renderer: AnyRenderer<RoutingDirection, ViewState>
    private let viewState: AbstractViewStatePublisher<ViewState>
    private let childrenStorage: RoutersStorage<RoutingDirection>

    public init(
        renderer: AnyRenderer<RoutingDirection, ViewState>,
        viewState: AbstractViewStatePublisher<ViewState>
    ) {
        self.renderer = renderer
        self.viewState = viewState
        childrenStorage = RoutersStorage<RoutingDirection>(invocationDelay: 0.05)
        print("<--- \(Self.self) inited")
    }

    open func makeRouter(for _: RoutingDirection) -> Router {
        fatalError("makeRouter(for destination: \(RoutingDirection.self) have to be overridden on subclassing")
    }

    private func router(for direction: RoutingDirection) -> Router {
        childrenStorage.existingRouter(for: direction, or: {
            print("<--- \(Self.self) activate routing for \(direction)".prefix(200))
            return self.makeRouter(for: direction)
        })
    }

    private func onActiveDirectionsUpdate(directions: [RoutingDirection]) {
        childrenStorage.deactivateAll(excluding: directions)
    }

    deinit {
        print("---> \(Self.self) deinited")
        childrenStorage.deactivateAll()
    }
}

extension AbstractRouter: Routing {
    public func routing(for direction: RoutingDirection) -> AnyView {
        router(for: direction).view
    }
}
