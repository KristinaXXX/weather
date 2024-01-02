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
        segmentedControl.selectedSegmentTintColor = .accent
        segmentedControl.backgroundColor = .clear

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: CustomFont.Regular16.font!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: CustomFont.Regular16.font!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        segmentedControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
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
        setupConstraints()
    }
    
    private func setupView() {
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .white
        title = "Дневная погода"
        view.addSubview(pageControl)
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
                setPage(to: i)
            }
            i += 1
        }
        reloadInputViews()
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            pageControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pageControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pageControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)//, constant: 16)
        ])
    }
    
    private func setPage(to indexTo: Int) {
        guard indexTo < pages.count else { return }
        var direction: NavigationDirection = .forward
        if let dailyForecastViewController = viewControllers?.first as? DailyForecastViewController, let currentIndex = pages.firstIndex(of: dailyForecastViewController ) {
            direction = indexTo > currentIndex ? .forward : .reverse
        }
        setViewControllers([pages[indexTo]], direction: direction, animated: true)
    }
    
    @objc
    private func pageControlValueChanged() {
        let currentPageIndex = pageControl.selectedSegmentIndex
        setPage(to: currentPageIndex)
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
        guard !completed else { return }
        guard let dailyForecastViewController = previousViewControllers.first as? DailyForecastViewController, let currentIndex = pages.firstIndex(of: dailyForecastViewController) else { return }
       
        pageControl.selectedSegmentIndex = currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let dailyForecastViewController = pendingViewControllers.first as? DailyForecastViewController, let currentIndex = pages.firstIndex(of: dailyForecastViewController) else { return }
        pageControl.selectedSegmentIndex = currentIndex
    }
}
