import Combine
import Foundation

public class MediaPresenter: AbstractViewStatePublisher<MediaViewState> {
    
    private let events = PassthroughSubject<MediaEvent, Never>()
    
    public init() {
        super.init(
            initial: ViewState(),
            dataEvents: events,
            reducer: Self.reduce
        )
    }
    
    private static func reduce(state: ViewState, event: MediaEvent) -> ViewState {}
}

extension MediaPresenter: MediaPresenting {}
