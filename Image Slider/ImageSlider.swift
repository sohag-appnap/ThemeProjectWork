//
//  ImageSlider.swift
//  TestDetailsPage
//
//  Created by Appnap WS07 on 10/11/20.
//

import UIKit

class ImageSlider: UIView {

    //MARK: - Properties
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.clipsToBounds = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let pageController = UIPageControl()
    
    var image = [String]()
    
    var currentIndex = 0
    var leftSwipe: Bool = true
    var rightSwipe: Bool = true
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ImageSliderCell.self, forCellWithReuseIdentifier: "sliderCell")
        pageController.numberOfPages = image.count
    }
    
    override func layoutSubviews() {
        addView()
    }
    
    //MARK: - Functions
    
    func addView() {
        addSubview(collectionView)
        addSubview(pageController)
        
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.96).isActive = true
        
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageController.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageController.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        
        pageController.addTarget(self, action: #selector(pageSelectorTapped), for: .touchUpInside)
        pagingControllerSetup(backGroundColor: .clear, pageIndicatorTintColor: #colorLiteral(red: 0, green: 0.6233851314, blue: 1, alpha: 1), currentPageIndicatorTintColor: #colorLiteral(red: 0.6408074498, green: 0.8464434743, blue: 1, alpha: 1))
    }
    
    func pagingControllerSetup(backGroundColor: UIColor, pageIndicatorTintColor: UIColor, currentPageIndicatorTintColor: UIColor ) {
        pageController.tintColor = #colorLiteral(red: 0, green: 0.6233851314, blue: 1, alpha: 1)
        pageController.backgroundColor = backGroundColor
        pageController.pageIndicatorTintColor = pageIndicatorTintColor
        pageController.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }
    
    //MARK: - Selectors
    
    @objc func pageSelectorTapped(_ sender: UIPageControl) {
        let index = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }

}

extension ImageSlider: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageController.numberOfPages = image.count
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! ImageSliderCell
        cell.setDetails(image: UIImage(named: image[indexPath.row])! )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        leftSwipe = true
        rightSwipe = true
        let index = IndexPath(item: pageController.currentPage, section: 0)
        collectionView.reloadItems(at: [index])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if collectionView.contentOffset.x < -40 && leftSwipe {
            rightSwipe = false
            collectionView.contentOffset.x =  (collectionView.frame.size.width * CGFloat(image.count)) + 40
        }
        else if collectionView.contentOffset.x > (collectionView.frame.size.width * CGFloat(image.count - 1)) + 40 && rightSwipe{
            leftSwipe = false
            collectionView.contentOffset.x =  -(collectionView.frame.size.width * CGFloat(image.count)) + 40
        }
        
    }

}
