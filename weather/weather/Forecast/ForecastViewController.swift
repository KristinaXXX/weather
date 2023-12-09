//
//  ForecastViewController.swift
//  weather
//
//  Created by Kr Qqq on 03.12.2023.
//

import UIKit

class ForecastViewController: UIViewController {

    private let viewModel: ForecastViewModel
    
    private lazy var menuBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "burger", selector: #selector(menuTabButtonPressed(_:)))
    }()
    
    private lazy var locationBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "location", selector: #selector(locationTabButtonPressed(_:)))
    }()

    private lazy var forecastTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherNowHeaderView.self, forHeaderFooterViewReuseIdentifier: WeatherNowHeaderView.id)
        tableView.register(HoursTableViewCell.self, forCellReuseIdentifier: HoursTableViewCell.id)
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: DaysTableViewCell.id)
        tableView.register(DaysHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: DaysHeaderFooterView.id)
        //tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    init(viewModel: ForecastViewModel) {
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
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
        navigationItem.rightBarButtonItems = [locationBarButtonItem]
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
    
    @objc
    private func menuTabButtonPressed(_ sender: UIButton) {
        
    }
    
    @objc
    private func locationTabButtonPressed(_ sender: UIButton) {
        
    }

}

extension ForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HoursTableViewCell.id, for: indexPath) as! HoursTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.id, for: indexPath) as! DaysTableViewCell
            cell.update()
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
            return 10
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
            186
        default:
            56
        }
    }
}

extension ForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherNowHeaderView.id) as! WeatherNowHeaderView
            headerView.update()
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
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
    }
    
}
