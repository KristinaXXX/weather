//
//  HoursTableViewCell.swift
//  weather
//
//  Created by Kr Qqq on 08.12.2023.
//

import UIKit

class HoursTableViewCell: UITableViewCell {

    static let id = "HoursTableViewCell"
    
    private lazy var hoursCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
       
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.id)
        collectionView.isUserInteractionEnabled = true
        
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
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            info24Label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 33),
            info24Label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            hoursCollection.topAnchor.constraint(equalTo: info24Label.bottomAnchor, constant: 24),
            hoursCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            hoursCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hoursCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func tapInfo24Label() {
        print("tapInfo24Label")
    }

}

extension HoursTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.id, for: indexPath) as! HourCollectionViewCell
        cell.update()
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
}

extension HoursTableViewCell: UICollectionViewDelegate {

}

extension HoursTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = collectionView.frame.width - 16*2
       CGSize(width: 42, height: 84)
       
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 20,
            right: 0
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 16 }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 1:
//            collectionView.deselectItem(at: indexPath, animated: true)
//            let habitRow = HabitsStore.shared.habits[indexPath.row]
//            navigationController?.pushViewController(HabitDetailsViewController(habit: habitRow), animated: true)
//        default:
//            return
//        }
//    }
    
}
