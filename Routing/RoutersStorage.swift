import Combine
import Foundation

class RoutersStorage<RoutingDirection: Hashable> {
    internal class RouterState {
        let router: Router
        let direction: RoutingDirection
        var removingFlag: UUID?

        init(router: Router, direction: RoutingDirection) {
            self.router = router
            self.direction = direction
        }
    }

    private enum Event {
        case activate(RoutingDirection, () -> Router)
        case prepareForRemovingExcluding([RoutingDirection], UUID)
        case remove(UUID)
    }

    fileprivate enum InitialEvent {
        case activate(RoutingDirection, () -> Router)
        case deactivateExcluding([RoutingDirection])
    }

    private let events = PassthroughSubject<InitialEvent, Never>()
    private let routers = CurrentValueSubject<[RouterState], Never>([])

    private let invocationDelay: TimeInterval
    private var cancellables = Set<AnyCancellable>()

    init(invocationDelay: TimeInterval) {
        self.invocationDelay = invocationDelay

        events.flatMap { initialEvent -> AnyPublisher<Event, Never> in
            switch initialEvent {
            case let .deactivateExcluding(directions):
                let id = UUID()
                return Just(Event.remove(id))
                    .delay(for: .seconds(invocationDelay), scheduler: DispatchQueue.main)
                    .prepend(Event.prepareForRemovingExcluding(directions, id))
                    .eraseToAnyPublisher()
            case let .activate(direction, makeNewRouter):
                return Just(Event.activate(direction, makeNewRouter))
                    .eraseToAnyPublisher()
            }
        }
        .scan([RouterState](), Self.reduce)
        .sink(receiveValue: routers.send)
        .store(in: &cancellables)
    }

    private static func reduce(currentValue: [RouterState], event: Event) -> [RouterState] {
        var currentValue = currentValue
        switch event {
        case let .activate(direction, makeRouter):
            if let router = currentValue.first(where: { $0.direction.hashValue == direction.hashValue }) {
                router.removingFlag = nil
            } else {
                currentValue.append(RouterState(router: makeRouter(), direction: direction))
            }
        case let .prepareForRemovingExcluding(directions, removingId):
            currentValue.forEach { routerState in
                guard !directions.contains(where: { $0.hashValue == routerState.direction.hashValue }) else {
                    routerState.removingFlag = nil
                    return
                }
                guard routerState.removingFlag == nil else {
                    return
                }
                routerState.removingFlag = removingId
            }
        case let .remove(removalId):
            currentValue.removeAll { $0.removingFlag == removalId }
        }
        return currentValue
    }

    func existingRouter(
        for direction: RoutingDirection,
        or makeRouter: @escaping () -> Router
    ) -> Router {
        events.send(.activate(direction, makeRouter))
        guard let router = routers.value.first(where: { $0.direction.hashValue == direction.hashValue })?.router else {
            fatalError("Can't find router for \(direction) after activation.")
        }
        return router
    }

    func deactivateAll(excluding activeRouters: [RoutingDirection] = []) {
        events.send(.deactivateExcluding(activeRouters))
    }
}
