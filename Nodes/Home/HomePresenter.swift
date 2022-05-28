import Combine
import Foundation
import SwiftUI

public class HomePresenter: AbstractViewStatePublisher<HomeViewState> {
    
    private let events = PassthroughSubject<HomeEvent, Never>()
    
    public init() {
        super.init(
            initial: ViewState(),
            dataEvents: events,
            reducer: Self.reduce
        )
    }
    
    private static func reduce(state: ViewState, event: HomeEvent) -> ViewState {}
}

extension HomePresenter: HomePresenting {}
