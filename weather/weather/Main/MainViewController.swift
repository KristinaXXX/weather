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
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = .main
        pageControl.currentPageIndicatorTintColor = .accent
        return pageControl
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
        setupConstraints()
    }
    
    private func setupView() {
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
        navigationItem.rightBarButtonItems = [locationBarButtonItem]
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .white
        view.addSubview(pageControl)
    }
    
    private func setupPages() {
        pages = viewModel.createPages()
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            if let forecastViewController = firstPage as? ForecastViewController {
                title = forecastViewController.cityName
            }
            pageControl.currentPage = 0
        }
        pageControl.numberOfPages = pages.count
        reloadInputViews()
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            pageControl.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    @objc
    private func menuTabButtonPressed(_ sender: UIButton) {
        viewModel.showSettings()
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
        pageControl.currentPage = currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let forecastViewController = pendingViewControllers.first as? ForecastViewController, let currentIndex = pages.firstIndex(of: forecastViewController) else { return }
        if let nextForecastViewController = pages[currentIndex] as? ForecastViewController {
            title = nextForecastViewController.cityName
        }
        pageControl.currentPage = currentIndex
    }
}

extension MainViewController: MainViewControllerDelegate {
    func updatePages() {
        setupPages()
    }
}
