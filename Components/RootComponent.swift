import Combine
import Foundation

public struct RootComponent: Component {
    let client: NetworkClient

    public init(
        client: NetworkClient
    ) {
        self.client = client
    }

    public func makeRoot() -> Router {
        let presenter = RootPresenter()
        let renderer = RootRenderer(presenter: presenter)
        return RootRouter(
            renderer: renderer.asAny(),
            viewState: presenter,
            makeCore: makeCore
        )
    }

    private func makeCore() -> Router {
        let presenter = CorePresenter()
        let renderer = CoreRenderer(presenter: presenter)
        return LeafRouter(
            renderer: renderer.asAny(),
            viewState: presenter
        )
    }
}
