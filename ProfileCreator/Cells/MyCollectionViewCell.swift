//
//  MyCollectionViewCell.swift
//  ProfileCreator
//
//  Created by Appnap WS11 on 8/11/20.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    let bg: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .cyan
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        contentView.addSubview(title)
        bg.anchorView(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        title.anchorView(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 8, height: 30)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
