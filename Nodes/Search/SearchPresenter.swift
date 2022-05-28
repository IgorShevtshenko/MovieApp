import Combine
import Foundation

public class SearchPresenter: AbstractViewStatePublisher<SearchViewState> {
    
    private let events = PassthroughSubject<SearchEvent, Never>()
    
    public init() {
        super.init(
            initial: ViewState(),
            dataEvents: events,
            reducer: Self.reduce
        )
    }
    
    private static func reduce(state: ViewState, event: SearchEvent) -> ViewState {}
}

extension SearchPresenter: SearchPresenting {}
