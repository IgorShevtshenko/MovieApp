import SwiftUI
import UIKit

open class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var sceneController: SceneController?

    public func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        let endpointConfiguaration = EndpointConfigurationImpl()
        let requestSerializer = JSONRequestSerializer()
        let client = NetworkClientImpl(endpointConfiguration: endpointConfiguaration, requestSerializer: requestSerializer)
        if let windowScene = scene as? UIWindowScene {
            sceneController = SceneController(
                windowScene: windowScene,
                makeContent: RootComponent(
                    client: client
                ).makeRoot
            )
        }
    }

    public func sceneDidDisconnect(_: UIScene) {}
    public func sceneDidBecomeActive(_: UIScene) {}
    public func sceneWillResignActive(_: UIScene) {}
    public func sceneWillEnterForeground(_: UIScene) {}
    public func sceneDidEnterBackground(_: UIScene) {}
}
