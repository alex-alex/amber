//
//  Question.swift
//  Amber
//
//  Created by Alex Studnicka on 23.10.2021.
//

import Foundation

enum QuestionType: String, Codable {
	case answers
	case text
}

final class Answer: Codable {

	let text: String
	let target: String?

}

final class Question: Codable {

	let id: String
	let header: String?
	let question: String
	let type: QuestionType
	let answers: [Answer]?
	let text: Answer?

}
