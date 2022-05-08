import Combine
import SwiftUI

public protocol Router {
    var view: AnyView { get }
}

public protocol Routing {
    associatedtype RoutingDirection: Hashable

    func routing(for direction: RoutingDirection) -> AnyView
}

public protocol ViewStateRenderer {
    associatedtype ViewState
    associatedtype OutputView: View
    associatedtype RoutingDirection: Hashable

    @ViewBuilder func render(state: ViewState, router: AnyRouting<RoutingDirection>) -> OutputView
}
