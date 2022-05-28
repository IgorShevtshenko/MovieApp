import Foundation

struct HomeComponent {
    
    let parent: CoreComponent
    
    init(parent: CoreComponent) {
        self.parent = parent
    }
    
    func makeHome() -> Router {
        let presenter = HomePresenter()
        let renderer = HomeRenderer(presenter: presenter)
        return HomeRouter(
            renderer: renderer.asAny(),
            viewState: presenter
        )
    }
}
