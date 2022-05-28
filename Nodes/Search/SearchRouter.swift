import Combine
import Foundation

public enum SearchRouting: Hashable {}

public class SearchRouter: AbstractRouter<SearchRouting, SearchViewState> {
    
    public override init(
        renderer: AnyRenderer<SearchRouting, SearchViewState>,
        viewState: AbstractViewStatePublisher<SearchViewState>
    ) {
        super.init(renderer: renderer, viewState: viewState)
    }

    public override func makeRouter(for destination: SearchRouting) -> Router {}
}
