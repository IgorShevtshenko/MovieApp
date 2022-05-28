import Combine
import Foundation

public enum HomeRouting: Hashable {}

public class HomeRouter: AbstractRouter<HomeRouting, HomeViewState> {
    
    public override init(
        renderer: AnyRenderer<HomeRouting, HomeViewState>,
        viewState: AbstractViewStatePublisher<HomeViewState>
    ) {
        super.init(renderer: renderer, viewState: viewState)
    }

    public override func makeRouter(for destination: HomeRouting) -> Router {}
}
