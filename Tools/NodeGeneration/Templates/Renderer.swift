import SwiftUI
import Foundation

public struct ${NODE_NAME}Renderer: ViewStateRenderer {
    
    private let presenter: ${NODE_NAME}Presenting
    
    public init(presenter: ${NODE_NAME}Presenting) {
        self.presenter = presenter
    }
    
    public func render(
        state: ${NODE_NAME}ViewState,
        router: AnyRouting<${NODE_NAME}Routing>
    ) -> some View {
        Text(\"${NODE_NAME} UI\")
    }
}
