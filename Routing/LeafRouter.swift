import Combine
import Foundation

public final class LeafRouter<ViewState>: AbstractRouter<Never, ViewState> {
    override public init(
        renderer: AnyRenderer<Never, ViewState>,
        viewState: AbstractViewStatePublisher<ViewState>
    ) {
        super.init(renderer: renderer, viewState: viewState)
    }
}
