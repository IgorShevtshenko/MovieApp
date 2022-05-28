import Combine
import Foundation

public enum MediaRouting: Hashable {}

public class MediaRouter: AbstractRouter<MediaRouting, MediaViewState> {
    
    public override init(
        renderer: AnyRenderer<MediaRouting, MediaViewState>,
        viewState: AbstractViewStatePublisher<MediaViewState>
    ) {
        super.init(renderer: renderer, viewState: viewState)
    }

    public override func makeRouter(for destination: MediaRouting) -> Router {}
}
