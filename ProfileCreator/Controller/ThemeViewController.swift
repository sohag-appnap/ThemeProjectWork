//
//  ThemeViewController.swift
//  ProfileCreator
//
//  Created by Appnap WS11 on 15/11/20.
//

import UIKit

class ThemeViewController: UIViewController {

    @IBOutlet weak var sliderView: ImageSlider!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topSpaceView: UIView!
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var tagCollection: UICollectionView!
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var optionVIew: UIView!
    @IBOutlet weak var mainViewHeightConstrait: NSLayoutConstraint!
    @IBOutlet weak var mainTopNavBar: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var blurOptionView: UIView!
    @IBOutlet weak var optionStackView: UIStackView!
    
    let image = [ "Slipknot","slip", "flower" ]
    let item = ["Slipknot","slip", "flower" , "Slipknot","slip", "flower" , "Slipknot","slip", "flower" ]
    var optionToggle: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.addBlurEffect()
        blurOptionView.addBlurEffect()
        sliderView.image = image
        scrollView.delegate = self
        scrollView.contentInset.top = view.frame.height * (0.140)
        topSpaceView.backgroundColor = .clear
        topNavView.backgroundColor = .clear
        tagCollection.dataSource = self
        tagCollection.delegate = self
        productCollection.dataSource = self
        productCollection.delegate = self
        optionVIew.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOptionView))
        optionVIew.addGestureRecognizer(tap)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        self.productCollection.addGestureRecognizer(longPressGesture)
        productCollection.dragInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        mainViewHeightConstrait.constant = view.frame.size.height * 0.881696429 + productCollection.contentSize.height - scrollView.frame.size.height - view.frame.height * (0.060)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func optionButtonPressed(_ sender: Any) {
        if optionToggle{
            UIView.animate(withDuration: 0.5) {
                self.blurOptionView.layer.shadowColor = UIColor.black.cgColor
                self.blurOptionView.layer.shadowOffset = CGSize(width: 0, height: 5)
                self.blurOptionView.layer.shadowRadius = 15
                self.blurOptionView.layer.shadowOpacity = 0.2
                //self.blurOptionView.dropShadow(color: UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 1), opacity: 0.5, offSet: CGSize(width: 5, height: 5), radius: 5, scale: true)
                self.optionVIew.isHidden = false
                self.blurOptionView.isHidden = false
            }
            optionToggle = false
        }
    }
    
    @objc func tapOptionView() {
        
        if !optionToggle{
            UIView.animate(withDuration: 0.5) {
                self.optionToggle = true
                self.optionVIew.isHidden = true
                self.blurOptionView.isHidden = true
            }
        }else{
            optionToggle = false
        }
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
      
      switch(gesture.state) {
      
      case .possible: break
        
      case .began:
          guard let selectedIndexPath = self.productCollection.indexPathForItem(at: gesture.location(in: self.productCollection)) else {
                          break
                      }
        productCollection.beginInteractiveMovementForItem(at: selectedIndexPath)
          print(selectedIndexPath)
        
      case .changed:
        productCollection.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
          print("selectedIndexPath")
        productCollection.reloadData()
      case .ended:
          break
      case .cancelled:
          break
      case .failed:
        productCollection.endInteractiveMovement()
      default:
        productCollection.cancelInteractiveMovement()
      }
      
    }
}

extension ThemeViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView==self.scrollView{
//            let offset = -view.frame.height * (0.140)
//            let newAlpha = 1 - (self.scrollView.contentOffset.y/offset)
//
//            if newAlpha >= 0 && newAlpha <= 1{
//                topSpaceView.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: newAlpha)
//                topNavView.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: newAlpha)
//                mainTopNavBar.dropShadow(color: UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: newAlpha), opacity: 0.5, offSet: CGSize(width: 5, height: 5), radius: 5, scale: true)
//
//            }else if newAlpha < 0{
//                topSpaceView.backgroundColor = .clear
//                topNavView.backgroundColor = .clear
//            }else{
//                topSpaceView.backgroundColor = .white
//                topNavView.backgroundColor = .white
//            }
//        }
        
    }
}

//MARK:- TagCollectionView Extension

extension ThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag{
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

        let item = self.item[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollection {
            return item.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == productCollection {
            let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
            return cell
        }
        let cell = tagCollection.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productCollection {
            return CGSize(width: (productCollection.frame.width - 36)/3  , height: (productCollection.frame.width - 36)/3)
        }
        return CGSize(width: 58, height: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == productCollection {
            return 15
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == productCollection {
            return 15
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if collectionView == productCollection {
            return true
        }
        return false
    }
}

extension UIView {

  // OUTPUT 1
      func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }

      // OUTPUT 2
      func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
//    func addBlurEffect(){
//        if !UIAccessibility.isReduceTransparencyEnabled {
//            self.backgroundColor = .clear
//
//            let blurEffect = UIBlurEffect(style: .extraLight)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            //always fill the view
//            blurEffectView.frame = self.bounds
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            self.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
//        } else {
//            self.backgroundColor = .white
//        }
//    }
}

