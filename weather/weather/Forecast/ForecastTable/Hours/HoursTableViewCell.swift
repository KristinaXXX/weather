//
//  HoursTableViewCell.swift
//  weather
//
//  Created by Kr Qqq on 08.12.2023.
//

import UIKit

protocol HoursTableViewCellDelegate: AnyObject {
    func showDetails()
}

class HoursTableViewCell: UITableViewCell, HoursTableViewCellDelegate {

    static let id = "HoursTableViewCell"
    private var dataForecastHours: [ForecastWeatherRealm] = []
    weak var forecastViewControllerDelegate: ForecastViewControllerDelegate?
    private var formatTime: Units = .hours24
    
    private lazy var hoursCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
       
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.id)
        //collectionView.isUserInteractionEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private lazy var info24Label: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular16.font
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(tapInfo24Label))
        view.addGestureRecognizer(gr)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    private func addSubviews() {
        contentView.addSubview(info24Label)
        contentView.addSubview(hoursCollection)
    }
    
    private func setupView() {
        backgroundColor = .white
        hoursCollection.dataSource = self
        hoursCollection.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            info24Label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            info24Label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            hoursCollection.topAnchor.constraint(equalTo: info24Label.bottomAnchor, constant: 24),
            hoursCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hoursCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hoursCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func update(forecastHours: [ForecastWeatherRealm], formatTime: Units) {
        dataForecastHours = forecastHours
        self.formatTime = formatTime
        hoursCollection.reloadData()
    }
    
    @objc
    private func tapInfo24Label() {
        forecastViewControllerDelegate?.showDetails()
    }
    
    func showDetails() {
        forecastViewControllerDelegate?.showDetails()
    }

}

extension HoursTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.id, for: indexPath) as! HourCollectionViewCell
        if dataForecastHours.count > indexPath.row {
            cell.hoursTableViewCellDelegate = self
            cell.update(forecastHour: dataForecastHours[indexPath.row], formatTime: formatTime)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
}

extension HoursTableViewCell: UICollectionViewDelegate {

}

extension HoursTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       CGSize(width: 42, height: 84)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 10,
            left: 0,
            bottom: 10,
            right: 0
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 16 }
}
