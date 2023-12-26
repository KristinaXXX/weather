//
//  DailyPagesViewController.swift
//  weather
//
//  Created by Kr Qqq on 26.12.2023.
//

import UIKit

class DailyPagesViewController: UIPageViewController {

    private var pages: [DailyForecastViewController] = []
    private let viewModel: DailyPagesViewModel
    
    private lazy var pageControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.contentVerticalAlignment = .center
        return segmentedControl
    }()
    
    init(viewModel: DailyPagesViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [.spineLocation: SpineLocation.min])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPages()
       // setupConstraints() 
    }
    
    private func setupView() {
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .white
        title = "Дневная погода"
        view.bringSubviewToFront(pageControl)// .addSubview(pageControl)
    }
    
    private func setupPages() {
        pages = viewModel.createPages()
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
        var i = 0
        while i < pages.count {
            pageControl.insertSegment(withTitle: viewModel.dayText(at: i), at: i, animated: true)
            if viewModel.isSelectDate(at: i) {
                pageControl.selectedSegmentIndex = i
            }
            i += 1
        }
        reloadInputViews()
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
}

extension DailyPagesViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard pages.first != viewController else { return nil }
        guard let dailyForecastViewController = viewController as? DailyForecastViewController, let currentIndex = pages.firstIndex(of: dailyForecastViewController) else { return nil }
        let page = pages[currentIndex - 1]
        return page
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard pages.last != viewController else { return nil }
        guard let dailyForecastViewController = viewController as? DailyForecastViewController, let currentIndex = pages.firstIndex(of: dailyForecastViewController) else { return nil }
        let page = pages[currentIndex + 1]
        return page
    }
}

extension DailyPagesViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        guard !completed else { return }
//        guard let dailyForecastViewController = previousViewControllers.first as? DailyForecastViewController, let currentIndex = pages.firstIndex(of: dailyForecastViewController) else { return }
        
      // title = nextForecastViewController.cityName
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        //guard let dailyForecastViewController = pendingViewControllers.first as? DailyForecastViewController, let currentIndex = pages.firstIndex(of: dailyForecastViewController) else { return }
       // title = nextForecastViewController.cityName
    }
}
