//
//  LikeView.swift
//  ProfileCreator
//
//  Created by Appnap WS11 on 5/11/20.
//

import UIKit

class LikeView: UIView {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("LikeView", owner: self, options: nil)
        addSubview(parentView)
    }
    
    func addValue(title: String){
        titleLabel.text = title
    }
    
    func loadViewFromNib() {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: nil)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = bounds
        addSubview(view)
    }
}
