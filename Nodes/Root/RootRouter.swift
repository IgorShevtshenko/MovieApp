import Foundation

public enum RootRouting: Hashable {
    case core
}

public class RootRouter: AbstractRouter<RootRouting, RootViewState> {
    private let makeCore: () -> Router

    public init(
        renderer: AnyRenderer<RootRouting, RootViewState>,
        viewState: AbstractViewStatePublisher<RootViewState>,
        makeCore: @escaping () -> Router
    ) {
        self.makeCore = makeCore
        super.init(renderer: renderer, viewState: viewState)
    }

    override public func makeRouter(for destination: RootRouting) -> Router {
        switch destination {
        case .core:
            return makeCore()
        }
    }
}
