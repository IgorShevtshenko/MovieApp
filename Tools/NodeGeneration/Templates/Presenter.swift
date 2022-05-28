import Combine
import Foundation

public class ${NODE_NAME}Presenter: AbstractViewStatePublisher<${NODE_NAME}ViewState> {
    
    private let events = PassthroughSubject<${NODE_NAME}Event, Never>()
    
    public init() {
        super.init(
            initial: ViewState(),
            dataEvents: events,
            reducer: Self.reduce
        )
    }
    
    private static func reduce(state: ViewState, event: ${NODE_NAME}Event) -> ViewState {}
}

extension ${NODE_NAME}Presenter: ${NODE_NAME}Presenting {}
