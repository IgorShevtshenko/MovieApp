import SwiftUI
import Foundation

public struct SearchRenderer: ViewStateRenderer {
    
    private let presenter: SearchPresenting
    
    public init(presenter: SearchPresenting) {
        self.presenter = presenter
    }
    
    public func render(
        state: SearchViewState,
        router: AnyRouting<SearchRouting>
    ) -> some View {
        Text("Search UI")
    }
}
