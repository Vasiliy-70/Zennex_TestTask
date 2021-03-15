//
//  SceneDelegate.swift
//  Zennex_TestTask
//
//  Created by Боровик Василий on 15.03.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		
		guard let window = self.window else {
			assertionFailure("Error: no window")
			return
		}
		window.windowScene = windowScene
		
		let navigationController = UINavigationController()
		navigationController.viewControllers = [ListViewAssembly.createListViewModule()]
		
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}

