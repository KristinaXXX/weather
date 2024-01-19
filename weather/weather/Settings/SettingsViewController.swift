//
//  SettingsViewController.swift
//  weather
//
//  Created by Kr Qqq on 31.12.2023.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewControllerDelegate {

    private let viewModel: SettingsViewModel
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        tableView.backgroundColor = .main
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .main
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var settingsLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Medium18.font
        view.text = "Настройки"
        return view
    }()
    
    private lazy var saveButton = CustomButton(title: "OK", buttonAction: ({ self.saveButtonPressed() }), color: .accentButton, font: CustomFont.Regular16.font)
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    private func tuneTableView() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .accent
    }
    
    func addSubviews() {
        view.addSubview(mainView)
        view.addSubview(settingsLabel)
        view.addSubview(settingsTableView)
        view.addSubview(saveButton)
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 28),
            mainView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -28),
            mainView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 270)
        ])
        
        NSLayoutConstraint.activate([
            settingsLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            settingsLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 28)
        ])
        
        NSLayoutConstraint.activate([
            settingsTableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            settingsTableView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 5),
            settingsTableView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            saveButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func updateSetting(_ setting: Settings) {
        viewModel.updateSetting(setting)
    }
    
    func saveButtonPressed() {
        dismiss(animated: true)
    }
}

protocol SettingsViewControllerDelegate: AnyObject {
    func updateSetting(_ setting: Settings)
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath) as! SettingsTableViewCell
        cell.delegate = self
        cell.update(viewModel.setting(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countSettings()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
