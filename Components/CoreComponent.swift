import Foundation

struct CoreComponent {
    
    let parent: RootComponent
    
    init(parent:RootComponent){
        self.parent = parent
    }
    
    func makeCore() -> Router {
        let presenter = CorePresenter()
        let renderer = CoreRenderer(presenter: presenter)
        return CoreRouter(
            renderer: renderer.asAny(),
            viewState: presenter,
            makeHome: makeHome,
            makeMedia: makeMedia,
            makeSearch: makeSearch
        )
    }
    
    private func makeHome() -> Router {
        HomeComponent(parent: self).makeHome()
    }
    
    private func makeMedia() -> Router {
        MediaComponent(parent: self).makeMedia()
    }
    
    private func makeSearch() -> Router {
        SearchComponent(parent: self).makeSearch()
    }
}
