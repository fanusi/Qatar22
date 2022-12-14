//
//  CategoryView.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import Foundation
import UIKit

internal protocol CategoryViewDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, selected: Int) -> UICollectionViewCell
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

public class CategoryView: UIView {
    internal var collectionView: UICollectionView!
    public var navigationView: UIView!
    public var items: [String] = []
    internal weak var delegate: CategoryViewDelegate?

    var observer: TabPageObserver! {
        didSet {
            observer.scrollObserver = self
            observer.navigationObserver = self
        }
    }

    private var isTapCell: Bool = false
    private var frames: [CGRect] = []

    public convenience init(frame: CGRect,
                            items: [String])
    {
        self.init(frame: frame)
        self.items = items
        confgiure()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var confgiure: () -> Void = {
        setCollectionView()
        setNavigation()
        setScrollView()
        setBoaderColor()
        frames = Emurate.frames(with: items, height: bounds.height)
        setCellsPosition()
        return {}
    }()

    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: bounds.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
    }

    private func setNavigation() {
        navigationView = UIView(frame: CGRect(x: 0, y: bounds.height - 3, width: 124, height: 3))
        navigationView.backgroundColor = .black
        addSubview(navigationView)
    }

    private func setScrollView() {
        let scrollView = collectionView.subviews.compactMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
    }

    private func setBoaderColor() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(border)
    }

    private func setCellsPosition() {
        moveNavigationView(index: 0)
    }

    private func moveNavigationView(index: Int) {
        let frame = frames[index]
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationView.frame = CGRect(x: frame.origin.x - self.collectionView.contentOffset.x,
                                               y: self.navigationView.frame.origin.y,
                                               width: frame.size.width,
                                               height: self.navigationView.frame.size.height)
        }) { [weak self] _ in
            self?.isTapCell = false
        }
    }
}

extension CategoryView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_: UICollectionView,
                               layout _: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if items.isEmpty {
            return .zero
        }
        return frames[indexPath.row].size
    }
}

extension CategoryView: UICollectionViewDataSource {
    public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return delegate?.collectionView(collectionView, cellForItemAt: indexPath, selected: observer.selected) ?? UICollectionViewCell()
    }
}

extension CategoryView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        observer.tabNotify(index: indexPath)
        observer.selected = indexPath.row
        isTapCell = true
        moveNavigationView(index: indexPath.row)
        collectionView.reloadData()
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

extension CategoryView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffsetX = scrollView.contentOffset.x

        let frame = frames[observer.selected]
        navigationView.frame = CGRect(x: frame.origin.x,
                                      y: navigationView.frame.origin.y,
                                      width: frame.size.width,
                                      height: navigationView.frame.size.height)
        navigationView.frame.origin.x = (scrollOffsetX * -1) + frame.origin.x
    }
}

extension CategoryView: TabObserver {
    func navigationViewObserver(index: Int) {
        observer.selected = index

        if observer.selected < 0 {
            observer.selected = 0
        } else if observer.selected > (items.count - 1) {
            observer.selected = items.count - 1
        }

        observer.moveNavigationNotify(index: observer.selected)

        moveNavigationView(index: observer.selected)
        collectionView.reloadData()
    }
}

extension CategoryView: PageViewObserver {
    func pageViewObserer(contentOffSet: CGPoint) {
        guard !isTapCell else {
            return
        }

        let movedPoint = contentOffSet.x - bounds.size.width

        let scrolRate = movedPoint * (navigationView.frame.size.width / frame.size.width)

        let frame = frames[observer.selected]
        navigationView.frame.origin.x = scrolRate + (frame.origin.x - collectionView.contentOffset.x)
    }
}

