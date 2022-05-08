import Combine

public extension Publisher where Output == Never {
    func andThen<T>(_ publisher: AnyPublisher<T, Failure>) -> AnyPublisher<T, Failure> {
        map { _ in T?(nilLiteral: ()) }
            .compactMap { $0 }
            .append(publisher)
            .eraseToAnyPublisher()
    }

    func andThen<Element>(justReturn output: Element) -> AnyPublisher<Element, Failure> {
        andThen(
            Just(output)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        )
    }

    func replaceError<T>(_ transform: @escaping (Failure) -> T) -> AnyPublisher<T, Never> {
        compactMap { _ in T?.none }
            .catch { Just(transform($0)) }
            .eraseToAnyPublisher()
    }
}

public extension Publisher {
    func ignoreFailure() -> AnyPublisher<Output, Never> {
        self.catch { _ in Empty<Output, Never>() }.eraseToAnyPublisher()
    }
}
