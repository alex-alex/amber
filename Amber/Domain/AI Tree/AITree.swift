//
//  AITree.swift
//  Amber
//
//  Created by Alex Studnicka on 23.10.2021.
//

import Foundation

final class AITree {

	static var questions: [Question]!

	static func setup() {
		let url = Bundle.main.url(forResource: "tree", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		questions = try! JSONDecoder().decode([Question].self, from: data)
	}

}
