import SwiftUI
import Foundation

public struct HomeRenderer: ViewStateRenderer {
    
    private let presenter: HomePresenting
    
    public init(presenter: HomePresenting) {
        self.presenter = presenter
    }
    
    public func render(
        state: HomeViewState,
        router: AnyRouting<HomeRouting>
    ) -> some View {
        Text("Home UI")
    }
}


