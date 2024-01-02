//
//  ForecastViewController.swift
//  weather
//
//  Created by Kr Qqq on 03.12.2023.
//

import UIKit

protocol ForecastViewControllerDelegate: AnyObject {
    func cancelUpdate()
    func updateHeader()
    func updateForecast()
    func showDetails()
}

class ForecastViewController: UIViewController, ForecastViewControllerDelegate {
    
    private let viewModel: ForecastViewModel
    let cityName: String
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление...")
        refreshControl.addTarget(self, action: #selector(refreshForecast(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()

    private lazy var forecastTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherNowHeaderView.self, forHeaderFooterViewReuseIdentifier: WeatherNowHeaderView.id)
        tableView.register(HoursTableViewCell.self, forCellReuseIdentifier: HoursTableViewCell.id)
        tableView.register(DayTableViewCell.self, forCellReuseIdentifier: DayTableViewCell.id)
        tableView.register(DaysHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: DaysHeaderFooterView.id)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.addSubview(refreshControl)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        return tableView
    }()
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        cityName = viewModel.cityName()
        super.init(nibName: nil, bundle: nil)
        viewModel.forecastViewControllerDelegate = self
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
        updateData()
    }
    
    private func updateData() {
        viewModel.updateWeather()
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
            forecastTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            forecastTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    func refreshForecast(_ sender: AnyObject) {
        updateData()
    }
    
    func updateHeader() {
        guard let headerView = forecastTableView.headerView(forSection: 0) as? WeatherNowHeaderView else { return }
        let currentWeather = viewModel.takeCurrentWeather()
        headerView.update(currentWeather, formatTime: viewModel.takeFormatTime())
    }
    
    func updateForecast() {
        forecastTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func showDetails() {
        viewModel.showDetails()
    }
    
    func cancelUpdate() {
        refreshControl.endRefreshing()
    }
}

extension ForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let forecastHours = viewModel.takeForecastHours()
            let cell = tableView.dequeueReusableCell(withIdentifier: HoursTableViewCell.id, for: indexPath) as! HoursTableViewCell
            cell.forecastViewControllerDelegate = self
            cell.update(forecastHours: forecastHours, formatTime: viewModel.takeFormatTime())
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.id, for: indexPath) as! DayTableViewCell
            cell.update(forecastDay: viewModel.takeForecastDay(at: indexPath.row))
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.countForecastDays()
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            153
        default:
            66
        }
    }
}

extension ForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherNowHeaderView.id) as! WeatherNowHeaderView
            let currentWeather = viewModel.takeCurrentWeather()
            headerView.update(currentWeather, formatTime: viewModel.takeFormatTime())
            return headerView
        case 1:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DaysHeaderFooterView.id) as! DaysHeaderFooterView
            return headerView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            tableView.deselectRow(at: indexPath, animated: true)
            viewModel.showDailyForecast(at: indexPath.row)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
    }
}
