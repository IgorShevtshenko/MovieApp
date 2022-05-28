import Combine
import Foundation

public enum CoreRouting: Hashable {
    case home
    case media
    case search
}

public class CoreRouter: AbstractRouter<CoreRouting, CoreViewState> {
    
    private let makeHome: () -> Router
    private let makeMedia: () -> Router
    private let makeSearch: () -> Router
    
    public init(
        renderer: AnyRenderer<CoreRouting, CoreViewState>,
        viewState: AbstractViewStatePublisher<CoreViewState>,
        makeHome: @escaping () -> Router,
        makeMedia: @escaping () -> Router,
        makeSearch: @escaping () -> Router
    ) {
        self.makeHome = makeHome
        self.makeMedia = makeMedia
        self.makeSearch = makeSearch
        super.init(renderer: renderer, viewState: viewState)
    }

    public override func makeRouter(for destination: CoreRouting) -> Router {
        switch destination {
        case .home:
            return makeHome()
        case .media:
            return makeMedia()
        case .search:
            return makeSearch()
        }
    }
}
