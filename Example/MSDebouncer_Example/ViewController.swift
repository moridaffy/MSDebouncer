//
//  ViewController.swift
//  MSDebouncer_Example
//
//  Created by Maxim Skryabin on 10.09.2021.
//

import UIKit

import MSDebouncer

class ViewController: UIViewController {
  
  private let valueLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.text = "Press buttons like crazy!"
    return label
  }()
  
  private lazy var button1 = getButton(withOrder: 1)
  private lazy var button2 = getButton(withOrder: 2)
  private lazy var button3 = getButton(withOrder: 3)
  private lazy var button4 = getButton(withOrder: 4)
  
  private func getButton(withOrder order: Int) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor.systemBlue
    button.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    button.setTitleColor(UIColor.white, for: .normal)
    button.setTitle(String(format: "Button %i", order), for: .normal)
    button.layer.cornerRadius = 4.0
    button.layer.masksToBounds = true
    return button
  }
  
  private var debouncer: Debouncer<String>?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupDebouncer()
    setupButtons()
  }
  
  private func setupLayout() {
    view.addSubview(valueLabel)
    view.addSubview(button1)
    view.addSubview(button2)
    view.addSubview(button3)
    view.addSubview(button4)
    
    view.addConstraints([
      valueLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
      valueLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
      valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      button1.topAnchor.constraint(greaterThanOrEqualTo: valueLabel.bottomAnchor, constant: 16.0),
      button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 16.0),
      button2.centerXAnchor.constraint(equalTo: button1.centerXAnchor),
      
      button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 16.0),
      button3.centerXAnchor.constraint(equalTo: button2.centerXAnchor),
      
      button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 16.0),
      button4.centerXAnchor.constraint(equalTo: button3.centerXAnchor),
      button4.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0)
    ])
  }
  
  private func setupDebouncer() {
    self.debouncer = Debouncer(outputType: String.self, callback: { [weak self] value in
      self?.valueLabel.text = [
        value ?? "empty title button",
        "tapped"
      ]
      .joined(separator: " ")
    })
  }
  
  private func setupButtons() {
    button1.addTarget(self, action: #selector(someButtonTapped(_:)), for: .touchUpInside)
    button2.addTarget(self, action: #selector(someButtonTapped(_:)), for: .touchUpInside)
    button3.addTarget(self, action: #selector(someButtonTapped(_:)), for: .touchUpInside)
    button4.addTarget(self, action: #selector(someButtonTapped(_:)), for: .touchUpInside)
  }
  
  @objc private func someButtonTapped(_ sender: UIButton) {
    valueLabel.text = "Debouncing..."
    
    debouncer?.setValue(sender.title(for: .normal))
  }
}
