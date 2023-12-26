//
//  DetailsViewController.swift
//  weather
//
//  Created by Kr Qqq on 22.12.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    private let viewModel: DetailsViewModel
    
    private lazy var hoursTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .plain //.grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.register(DetailsHourTableViewCell.self, forHeaderFooterViewReuseIdentifier: DetailsHourTableViewCell.id)
        tableView.register(DetailsHourTableViewCell.self, forCellReuseIdentifier: DetailsHourTableViewCell.id)
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
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
        hoursTableView.dataSource = self
        hoursTableView.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Прогноз на 24 часа"
    }
    
    func addSubviews() {
        view.addSubview(hoursTableView)
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            hoursTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            hoursTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            hoursTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            hoursTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsHourTableViewCell.id, for: indexPath) as! DetailsHourTableViewCell
        cell.update(forecastDay: viewModel.takeDetailHour(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countDetailsHour()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        165
    }
}

extension DetailsViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 0:
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherNowHeaderView.id) as! WeatherNowHeaderView
//            let currentWeather = viewModel.takeCurrentWeather()
//            headerView.update(currentWeather)
//            return headerView
//        case 1:
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DaysHeaderFooterView.id) as! DaysHeaderFooterView
//            return headerView
//        default:
//            return nil
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
