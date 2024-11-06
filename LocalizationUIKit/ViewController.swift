//
//  ViewController.swift
//  LocalizationUIKit
//
//  Created by Zeljko Marinkovic on 06/11/2024.
//

import UIKit

class ViewController: UIViewController, LanguageManagerServiceListener {
    // MARK: - Subviews
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.0
//        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var StringLocalizedGroup = UIView()
    
    private lazy var StringLocalizedGroupDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "String(localized: String) localization"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        return label
    }()
    
    private lazy var StringLocalizedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = String(localized: "Hi world!")
        label.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        
        return label
    }()
    
    private lazy var NSlocalizedStringGroup = UIView()
    
    private lazy var NSlocalizedStringGroupDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "NSLocalizedString(String, comment: String) localization"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        return label
    }()
    
    private lazy var NSlocalizedStringLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = NSLocalizedString("Hi world!", comment: "")
        label.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("Change Language", for: .normal)
        
        return button
    }()
    
    let langCodes: [String] = ["en","nb","sr"]
    
    let localization = LanguageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        localization.listener = self
        
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        initStackView(in: view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        
        initButton(in: view)
    }
    
    func initStackView(in container: UIView) {
        container.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30.0),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30.0)
        ])
        
        NSLayoutConstraint.activate([
            StringLocalizedGroup.heightAnchor.constraint(equalToConstant: 120.0),
            NSlocalizedStringGroup.heightAnchor.constraint(equalToConstant: 120.0)
        ])
        
        stackView.addArrangedSubview(StringLocalizedGroup)
        initLabel(StringLocalizedLabel, description: StringLocalizedGroupDescription, in: StringLocalizedGroup)
        
        stackView.addArrangedSubview(NSlocalizedStringGroup)
        initLabel(NSlocalizedStringLabel, description: NSlocalizedStringGroupDescription, in: NSlocalizedStringGroup)
    }
    
    private func initLabel(_ label: UILabel, description: UILabel, in container: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        description.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(description)
        container.addSubview(label)

        NSLayoutConstraint.activate([
            description.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            description.topAnchor.constraint(equalTo: container.topAnchor),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
    
    private func initButton(in container: UIView) {
        container.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20.0),
        ])
    }
    
    @objc
    private func changeLanguage() {
        let currentLang = langCodes.randomElement() ?? "en"
        localization.currentLanguage = currentLang
    }
    
    func localize(_ languageManager: LanguageManager) {
        StringLocalizedLabel.text = String(localized: "Hi world!")
        NSlocalizedStringLabel.text = NSLocalizedString("Hi world!", comment: "")
    }
}

@available(iOS 17, *)
#Preview {
    ViewController()
}
