//
//  ListMovieHeaderView.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class ListMovieHeaderView: UITableViewHeaderFooterView {
    let cellId = "cellId"
    var nowPlayingMovieArray = [NowPlayingResult]()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        return cv
    }()

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.backgroundColor = .clear
        pc.currentPage = 0
        pc.numberOfPages = 6
        pc.pageIndicatorTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        pc.currentPageIndicatorTintColor = .white
        pc.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return pc
    }()

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension ListMovieHeaderView : SetupView {
    func buildViewHierarchy() {
        self.addSubviews(collectionView, pageControl)
    }
    
    func setupConstraints() {
        collectionView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        pageControl.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListMovieHeaderCell.self, forCellWithReuseIdentifier: cellId)
    }
}

extension ListMovieHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListMovieHeaderCell
            cell.headerCellConfigure(movieItem: nowPlayingMovieArray[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.Sizes.collectionViewCellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
            if visibleIndexPath.row == 6 {
                self.collectionView.contentOffset.x = 0
                self.pageControl.currentPage = 0
            }
        }
    }
}
