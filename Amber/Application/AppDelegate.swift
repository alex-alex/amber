//
//  AppDelegate.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder {

	var window: UIWindow?

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		AITree.setup()

		window?.tintColor = .systemPink

		return true
	}

}
