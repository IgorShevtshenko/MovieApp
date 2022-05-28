import Foundation

struct SearchComponent {
    
    let parent: CoreComponent
    
    func makeSearch() -> Router {
        let presenter = SearchPresenter()
        let renderer = SearchRenderer(presenter: presenter)
        return SearchRouter(
            renderer: renderer.asAny(),
            viewState: presenter
        )
    }
}
