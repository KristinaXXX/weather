//
//  DailyForecastViewController.swift
//  weather
//
//  Created by Kr Qqq on 26.12.2023.
//

import UIKit

class DailyForecastViewController: UIViewController {

    private let viewModel: DailyForecastViewModel
    let cityName: String
    
    private lazy var forecastTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .plain //.grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.id)
        tableView.register(DailyForecastFooterView.self, forHeaderFooterViewReuseIdentifier: DailyForecastFooterView.id)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    init(viewModel: DailyForecastViewModel) {
        self.viewModel = viewModel
        cityName = viewModel.cityName()
        super.init(nibName: nil, bundle: nil)
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
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(forecastTableView)
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            forecastTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            forecastTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            forecastTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            forecastTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DailyForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.id, for: indexPath) as! DailyForecastTableViewCell
        cell.update(forecastDay: viewModel.takeDayPart(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countParts()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       340
    }
}

extension DailyForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DailyForecastFooterView.id) as! DailyForecastFooterView
        headerView.update(/*viewModel.sunDetails()*/)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
}
