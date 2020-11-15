//
//  ImageSliderCell.swift
//  TestDetailsPage
//
//  Created by Appnap WS07 on 10/11/20.
//

import UIKit

class ImageSliderCell: UICollectionViewCell {
    
    //MARK: - Properties

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - LifeCycles
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addView()
    }
    
    //MARK: - Functions
    
    func addView() {
        addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    func setDetails(image: UIImage) {
        imageView.image = image
    }
}
