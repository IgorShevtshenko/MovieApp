import Combine

public protocol PublishedViewState: ObservableObject {
    associatedtype ViewState
    var viewState: ViewState { get }
}
