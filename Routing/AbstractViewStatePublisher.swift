import Combine

open class AbstractViewStatePublisher<ViewState>: PublishedViewState {
    public typealias ViewState = ViewState

    @Published public private(set) var viewState: ViewState

    public init<Event, EventPublisher: Publisher>(
        initial: ViewState,
        dataEvents: EventPublisher,
        reducer: @escaping (ViewState, Event) -> ViewState
    ) where EventPublisher.Output == Event, EventPublisher.Failure == Never {
        viewState = initial
        dataEvents.scan(initial, reducer).prepend(initial).assign(to: &$viewState)
    }

    public init(constantState: ViewState) {
        viewState = constantState
    }
}
