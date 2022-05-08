import Combine
import Foundation

public class RootPresenter: AbstractViewStatePublisher<RootViewState> {
    private let events = PassthroughSubject<RootEvent, Never>()

    public init() {
        super.init(
            initial: ViewState(),
            dataEvents: events,
            reducer: Self.reduce
        )
    }

    private static func reduce(state: ViewState, event _: RootEvent) -> ViewState {
        return state
    }
}

extension RootPresenter: RootPresenting {}
