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

		window?.tintColor = .accent

		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.firstLineHeadIndent = 8

		UINavigationBar.appearance().largeTitleTextAttributes = [
			.font: UIFont(name: "HiraMinProN-W6", size: 32)!,
			.baselineOffset: 2,
			.paragraphStyle: paragraphStyle
		]

		if let tabBarVc = window?.rootViewController as? UITabBarController {
			tabBarVc.tabBar.tintColor = .secondary

			let background = UIView()
			background.backgroundColor = .white
			background.translatesAutoresizingMaskIntoConstraints = false
			tabBarVc.tabBar.addSubview(background)
			NSLayoutConstraint.activate([
				background.bottomAnchor.constraint(equalTo: tabBarVc.tabBar.topAnchor),
				background.centerXAnchor.constraint(equalTo: tabBarVc.tabBar.centerXAnchor),
				background.widthAnchor.constraint(equalTo: tabBarVc.tabBar.widthAnchor),
				background.heightAnchor.constraint(equalToConstant: 16)
			])

			let line = UIView()
			line.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 1.00)
			line.translatesAutoresizingMaskIntoConstraints = false
			tabBarVc.tabBar.addSubview(line)
			NSLayoutConstraint.activate([
				line.topAnchor.constraint(equalTo: background.topAnchor),
				line.centerXAnchor.constraint(equalTo: tabBarVc.tabBar.centerXAnchor),
				line.widthAnchor.constraint(equalTo: tabBarVc.tabBar.widthAnchor, constant: -48),
				line.heightAnchor.constraint(equalToConstant: 1.5)
			])

			tabBarVc.selectedIndex = 1
		}

		return true
	}

}
