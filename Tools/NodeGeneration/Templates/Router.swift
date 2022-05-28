import Combine
import Foundation

public enum ${NODE_NAME}Routing: Hashable {}

public class ${NODE_NAME}Router: AbstractRouter<${NODE_NAME}Routing, ${NODE_NAME}ViewState> {
    
    public override init(
        renderer: AnyRenderer<${NODE_NAME}Routing, ${NODE_NAME}ViewState>,
        viewState: AbstractViewStatePublisher<${NODE_NAME}ViewState>
    ) {
        super.init(renderer: renderer, viewState: viewState)
    }

    public override func makeRouter(for destination: ${NODE_NAME}Routing) -> Router {}
}
