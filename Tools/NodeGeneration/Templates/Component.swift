import Foundation

struct ${NODE_NAME}Component {
    
    let parent: <#T##Any#>
    
    init(parent: <#T##Any#>) {
        
    }
    
    func make${NODE_NAME}() -> Router {
        let presenter = ${NODE_NAME}Presenter()
        let renderer = ${NODE_NAME}Renderer(presenter: presenter)
        return ${NODE_NAME}Router(
            renderer: renderer.asAny(),
            viewState: presenter
        )
    }
}
