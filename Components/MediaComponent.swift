import Foundation

struct MediaComponent {
    
    let parent: CoreComponent
    
    func makeMedia() -> Router {
        let presenter = MediaPresenter()
        let renderer = MediaRenderer(presenter: presenter)
        return MediaRouter(
            renderer: renderer.asAny(),
            viewState: presenter
        )
    }
}
