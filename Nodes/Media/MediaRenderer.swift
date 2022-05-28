import SwiftUI
import Foundation

public struct MediaRenderer: ViewStateRenderer {
    
    private let presenter: MediaPresenting
    
    public init(presenter: MediaPresenting) {
        self.presenter = presenter
    }
    
    public func render(
        state: MediaViewState,
        router: AnyRouting<MediaRouting>
    ) -> some View {
        Text("Media UI")
    }
}
