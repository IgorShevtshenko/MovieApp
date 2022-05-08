import Combine
import Foundation

public class CorePresenter: AbstractViewStatePublisher<CoreViewState> {
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

extension CorePresenter: CorePresenting {}
