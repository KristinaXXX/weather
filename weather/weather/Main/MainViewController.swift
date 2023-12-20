//
//  MainViewController.swift
//  weather
//
//  Created by Kr Qqq on 19.12.2023.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func updatePages()
}

class MainViewController: UIPageViewController {

    private var pages: [UIViewController] = []
    private let viewModel: MainViewModel
   
    private lazy var menuBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "text.justify.right", selector: #selector(menuTabButtonPressed(_:)))
    }()
    
    private lazy var locationBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "location.viewfinder", selector: #selector(locationTabButtonPressed(_:)))
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [.spineLocation: SpineLocation.min])
        viewModel.mainViewControllerDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPages()
    }
    
    private func setupView() {
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
        navigationItem.rightBarButtonItems = [locationBarButtonItem]
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .white
    }
    
    private func setupPages() {
        pages = viewModel.createPages()
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            if let forecastViewController = firstPage as? ForecastViewController {
                title = forecastViewController.cityName
            }
        }
        reloadInputViews()
    }
    
    @objc
    private func menuTabButtonPressed(_ sender: UIButton) {
    }
    
    @objc
    private func locationTabButtonPressed(_ sender: UIButton) {
        viewModel.showMap()
    }
}

extension MainViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard pages.first != viewController else { return nil }
        guard let forecastViewController = viewController as? ForecastViewController, let currentIndex = pages.firstIndex(of: forecastViewController) else { return nil }
        let page = pages[currentIndex - 1]
        return page
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard pages.last != viewController else { return nil }
        guard let forecastViewController = viewController as? ForecastViewController, let currentIndex = pages.firstIndex(of: forecastViewController) else { return nil }
        let page = pages[currentIndex + 1]
        return page
    }
}

extension MainViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard !completed else { return }
        guard let forecastViewController = previousViewControllers.first as? ForecastViewController, let currentIndex = pages.firstIndex(of: forecastViewController) else { return }
        
        if let nextForecastViewController = pages[currentIndex] as? ForecastViewController {
            title = nextForecastViewController.cityName
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let forecastViewController = pendingViewControllers.first as? ForecastViewController, let currentIndex = pages.firstIndex(of: forecastViewController) else { return }
        if let nextForecastViewController = pages[currentIndex] as? ForecastViewController {
            title = nextForecastViewController.cityName
        }
    }
}

extension MainViewController: MainViewControllerDelegate {
    func updatePages() {
        setupPages()
    }
}
