import SwiftUI

public final class SceneController {
    private let contentWindow: UIWindow
    private let makeContent: () -> Router

    public init(
        windowScene: UIWindowScene,
        makeContent: @escaping () -> Router
    ) {
        contentWindow = UIWindow(windowScene: windowScene)
        self.makeContent = makeContent
        setup()
    }

    private func setup() {
        contentWindow.rootViewController = UIHostingController(rootView: makeContent().view)
        contentWindow.makeKeyAndVisible()
    }
}
