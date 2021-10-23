//
//  AmberViewController.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit
import Lottie
import AVFAudio

class AmberViewController: UIViewController {

	@IBOutlet private weak var animationView: AnimationView!
	@IBOutlet private weak var stackView: UIStackView!

	private let synthesizer = AVSpeechSynthesizer()

	var question: Question!

}

// MARK: - UIViewController

extension AmberViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		if question == nil {
			question = AITree.questions.first(where: { $0.id == "main" })
			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
				self.synthesizer.speak(AVSpeechUtterance(string: self.question.header! + "\n" + self.question.question))
			}
		} else {
			synthesizer.speak(AVSpeechUtterance(string: question.question))
		}

		stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

		if let header = question.header {
			let headerLabel = UILabel()
			headerLabel.text = header
			headerLabel.font = UIFont(name: "HiraMinProN-W6", size: 32)
			headerLabel.numberOfLines = 0
			headerLabel.baselineAdjustment = .none
			stackView.addArrangedSubview(headerLabel)
			headerLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
		}

		let label = UILabel()
		label.font = UIFont(name: "HiraMinProN-W3", size: 28)
		label.numberOfLines = 0
		label.baselineAdjustment = .alignCenters
		stackView.addArrangedSubview(label)
		label.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true

		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.minimumLineHeight = 40
		let attrStr = NSAttributedString(
			string: question.question,
			attributes: [
				.baselineOffset: 2,
				.paragraphStyle: paragraphStyle
			]
		)
		label.attributedText = attrStr

		let spacing = UIView()
		stackView.addArrangedSubview(spacing)
		spacing.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
		spacing.heightAnchor.constraint(equalToConstant: 1).isActive = true

		switch question.type {
		case .answers:
			for answer in question.answers! {
				var config = UIButton.Configuration.tinted()
				config.cornerStyle = .capsule
				config.contentInsets = .init(top: 8, leading: 32, bottom: 8, trailing: 32)
				config.background.strokeWidth = 1.5
				config.background.backgroundColor = .clear
				config.background.strokeColor = .accent

				let button = FilledButton(configuration: config, primaryAction: UIAction(handler: { _ in
					guard
						let target = answer.target,
						let question = AITree.questions.first(where: { $0.id == target })
					else { return }
					let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AmberViewController") as! AmberViewController
					vc.question = question
					self.navigationController?.pushViewController(vc, animated: true)
				}))
				button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
				button.setTitle(answer.text, for: .normal)
				stackView.addArrangedSubview(button)
				button.heightAnchor.constraint(equalToConstant: 42).isActive = true
			}

		case .text:
			var config = UIButton.Configuration.tinted()
//			config.cornerStyle = .fixed
			config.background.strokeWidth = 1.5
			config.background.strokeColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 0.16)
			config.background.backgroundColor = .clear
			config.background.cornerRadius = 6
			config.baseForegroundColor = .black
			config.titleAlignment = .leading

			let button = UIButton(configuration: config, primaryAction: UIAction(handler: { _ in
				guard
					let target = self.question.text?.target,
					let question = AITree.questions.first(where: { $0.id == target })
				else { return }
				let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AmberViewController") as! AmberViewController
				vc.question = question
				self.navigationController?.pushViewController(vc, animated: true)
			}))
			button.contentHorizontalAlignment = .leading
			button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
			button.setTitle(question.text?.text, for: .normal)
			stackView.addArrangedSubview(button)
			button.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
			button.heightAnchor.constraint(equalToConstant: 58).isActive = true
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		animationView.play(fromProgress: nil, toProgress: 1, loopMode: .autoReverse, completion: nil)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		animationView.stop()
	}

}
