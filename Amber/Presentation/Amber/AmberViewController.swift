//
//  AmberViewController.swift
//  Amber
//
//  Created by Alex Studnicka on 22.10.2021.
//

import UIKit
import Lottie

class AmberViewController: UIViewController {

	@IBOutlet weak var animationView: AnimationView!
	@IBOutlet weak var stackView: UIStackView!

	var question: Question!

}

// MARK: - UIViewController

extension AmberViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		if question == nil {
			question = AITree.questions.first(where: { $0.id == "main" })
		}

		stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

		let label = UILabel()
		label.text = question.question
		label.font = UIFont.systemFont(ofSize: 26)
		label.numberOfLines = 0
		stackView.addArrangedSubview(label)
		label.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true

		let spacing = UIView()
		stackView.addArrangedSubview(spacing)
		spacing.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
		spacing.heightAnchor.constraint(equalToConstant: 1).isActive = true

		switch question.type {
		case .answers:
			for (i, answer) in question.answers!.enumerated() {
				let config = UIButton.Configuration.tinted()
				let button = UIButton(configuration: config, primaryAction: UIAction(handler: { _ in
					let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AmberViewController") as! AmberViewController
					vc.question = AITree.questions.first(where: { $0.id == answer.target })
					self.navigationController?.pushViewController(vc, animated: true)
				}))
				button.tag = i
				button.setTitle(answer.text, for: .normal)
				stackView.addArrangedSubview(button)
			}

		case .text:
			break
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
