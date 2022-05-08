public protocol Component {
    associatedtype Parent
    var parent: Parent { get }
}

@dynamicMemberLookup
public struct Dependencies<CurrentComponent: Component> {
    private let component: CurrentComponent

    init(component: CurrentComponent) {
        self.component = component
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<CurrentComponent, T>) -> T {
        component[keyPath: keyPath]
    }

    public subscript<T>(
        dynamicMember keyPath: KeyPath<Dependencies<CurrentComponent.Parent>, T>
    ) -> T {
        component.parent.dependencies[keyPath: keyPath]
    }
}

public extension Component {
    var dependencies: Dependencies<Self> {
        Dependencies(component: self)
    }
}

extension Never: Component {
    public var parent: Never {
        fatalError("Shouldn't be caller")
    }

    public typealias Parent = Never
}

public extension Component where Parent == Never {
    var parent: Never { fatalError("Shouldn't be caller") }
}
