import Combine

public typealias ProtectedPublisher<Output> = AnyPublisher<Output, Never>
public typealias Completable<Failure: Error> = AnyPublisher<Never, Failure>

public extension Publisher where Failure == Never {
    func scanToState<State>(
        _ initial: State,
        reducer: @escaping (State, Output) -> State
    ) -> ProtectedPublisher<State> {
        scan(initial, reducer).prepend(initial).eraseToAnyPublisher()
    }
}
