//
//  ViewController.swift
//  ProfileCreator
//
//  Created by Appnap WS11 on 5/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var following: Bool = false
    private var topInset: CGFloat = 0

    private let mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let navigationView : UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        view.addBlurEffect()
        return view
    }()
    
    private let navigationTitle  : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20)
        view.textAlignment = .left
        view.backgroundColor = .clear
        view.text = "Sohag's Profile"
        return view
    }()
    
    private let optionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "optionIos"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private let optionStackView: UIStackView = {
        let view = UIStackView()
        view.isHidden = true
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.2
        view.addBlurEffect()
        return view
    }()
    
    private let profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let roundView  : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let titleName  : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textAlignment = .center
        view.backgroundColor = .clear
        view.text = "Title"
        return view
    }()
    
    private let userId  : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textAlignment = .center
        view.backgroundColor = .clear
        view.text = "@userName"
        return view
    }()
    
    private let userNameStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 4
        view.backgroundColor = .clear
        return view
    }()
    
    private let likeStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 20
        view.backgroundColor = .clear
        return view
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(followButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let followers : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textAlignment = .center
        view.backgroundColor = .clear
        view.adjustsFontSizeToFitWidth = true
        view.text = "15,926 Followers"
        return view
    }()
    
    private let followerStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        view.backgroundColor = .clear
        return view
    }()
    
    private let themeTypeStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        view.backgroundColor = .clear
        return view
    }()
    
    private let privateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Private", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.alpha = 0.5
        button.tag = 1
        button.addTarget(self, action: #selector(themeTypeButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let publishedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Published", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.tag = 2
        button.addTarget(self, action: #selector(themeTypeButtonAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("followButton", followButton.frame.size.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Size: ",profileCollectionView.contentSize.height)
        updateScrollViewContentSize()
        followButton.layer.cornerRadius = followButton.frame.height/2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count==1{
            if !optionStackView.isHidden{
                optionStackView.isHidden = true
                view.layoutIfNeeded()
            }
        }
    }
    
    func updateScrollViewContentSize(){
        let size = profileCollectionView.contentSize.height + (view.height*0.4)
        mainScrollView.contentSize.height = size > (view.height + topInset) ? size : (view.height + topInset)
    }
    
    func loadUI(){
        view.addSubview(mainScrollView)
        view.addSubview(navigationView)
        navigationView.addSubview(navigationTitle)
        
        mainScrollView.addSubview(roundView)
        mainScrollView.addSubview(userNameStack)
        mainScrollView.addSubview(likeStack)
        mainScrollView.addSubview(profileCollectionView)
        mainScrollView.addSubview(followerStack)
        mainScrollView.addSubview(themeTypeStack)
        
        view.addSubview(optionButton)
        view.addSubview(optionStackView)
        
        mainScrollView.delegate = self
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        navigationView.anchorView(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: view.height * 0.14)
        
        topInset = view.height * 0.11164
        mainScrollView.anchorView(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        mainScrollView.contentInset.top = topInset
        
        roundView.anchorView(top: mainScrollView.topAnchor, left: view.leftAnchor, paddingLeft: view.width * 0.17391304, width: view.frame.width / 4, height: view.frame.width / 4)
        roundView.layer.cornerRadius = view.frame.width / 8
        
        userNameStack.anchorView(top: roundView.bottomAnchor, left: view.leftAnchor, right: roundView.rightAnchor, paddingTop: 16, paddingLeft: view.width * 0.17391304, height: 40)
        userNameStack.addArrangedSubview(titleName)
        userNameStack.addArrangedSubview(userId)
        
        likeStack.anchorView(top: userNameStack.bottomAnchor, paddingTop: 24, width: view.width * 0.72463768, height: view.height * 0.08258929)
        likeStack.centerX(inView: view)
        profileInfoViews()
        
        themeTypeStack.anchorView(top: likeStack.bottomAnchor, paddingTop: 24, width: view.width * 0.45, height: view.height * 0.04241071)
        themeTypeStack.centerX(inView: view)
        addThemeTypeAttributes()
        
        profileCollectionView.anchorView(top: themeTypeStack.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        optionButton.anchorView(bottom: navigationView.bottomAnchor, right: view.rightAnchor, width: 80, height: 80)
        navigationTitle.anchorView(left: navigationView.leftAnchor, bottom: navigationView.bottomAnchor, right: optionButton.leftAnchor, paddingLeft: 20, height: 80)
        optionStackView.anchorView(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 16, paddingRight: 20, width: 124, height: 189)
        addOptioButtons()
        
        followerStack.anchorView(top: roundView.centerYAnchor, right: view.rightAnchor, paddingRight: view.width * 0.17391304, width: view.width * 0.24, height: view.height * 0.0703125)
        addFollowerAttributes()
    }
    
    func profileInfoViews() {
        let view1 = LikeView()
        let view2 = LikeView()
        let view3 = LikeView()
        
        view1.addValue(title: "16k Views")
        view2.addValue(title: "10k Likes")
        view3.addValue(title: "16k Contents")
        
        likeStack.addArrangedSubview(view1)
        likeStack.addArrangedSubview(view2)
        likeStack.addArrangedSubview(view3)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button Tapped")
        if optionStackView.isHidden{
            self.optionStackView.alpha = 0
            self.optionStackView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.2) {
                self.optionStackView.isHidden = false
                self.optionStackView.alpha = 1
                self.optionStackView.transform = CGAffineTransform.identity
            } completion: { (success) in
                print("Completed")
                self.view.layoutIfNeeded()
            }
        }

    }
    
    @objc func themeTypeButtonAction(sender: UIButton!) {
        sender.flash()
        print("Button Tapped")
        if sender.tag == 1{
            privateButton.isEnabled = false
            publishedButton.isEnabled = true
            privateButton.alpha = 1
            publishedButton.alpha = 0.5
        }else{
            publishedButton.isEnabled = false
            privateButton.isEnabled = true
            publishedButton.alpha = 1
            privateButton.alpha = 0.5
        }
        profileCollectionView.reloadData()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            print("ProfileContentSize: ",self.profileCollectionView.contentSize.height)
            self.updateScrollViewContentSize()
        }
    }
    
    func addOptioButtons(){
        let button1 = newButton(title: "Share", tag: 1, fontSize: 15)
        let button2 = newButton(title: "Make Private", tag: 2, fontSize: 15)
        let button3 = newButton(title: "Delete", tag: 3, fontSize: 15)
        let button4 = newButton(title: "Uses Terms", tag: 4, fontSize: 15)
        
        button1.addTarget(self, action: #selector(optionButtonAction), for: .touchUpInside)
        button2.addTarget(self, action: #selector(optionButtonAction), for: .touchUpInside)
        button3.addTarget(self, action: #selector(optionButtonAction), for: .touchUpInside)
        button4.addTarget(self, action: #selector(optionButtonAction), for: .touchUpInside)
        
        optionStackView.addArrangedSubview(button1)
        optionStackView.addArrangedSubview(button2)
        optionStackView.addArrangedSubview(button3)
        optionStackView.addArrangedSubview(button4)
    }
    
    func addFollowerAttributes(){
        followerStack.addArrangedSubview(followButton)
        followerStack.addArrangedSubview(followers)
    }
    
    func addThemeTypeAttributes(){
        themeTypeStack.addArrangedSubview(privateButton)
        themeTypeStack.addArrangedSubview(publishedButton)
    }
    
    func newButton(title: String, tag: Int, fontSize: CGFloat)->UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.tag = tag
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: fontSize)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return button
    }
    
    @objc func optionButtonAction(sender: UIButton!) {
        sender.flash()
        
        switch sender.tag {
        case 1:
            print("Share Button Pressed")
        case 2:
            print("Make Private Button Pressed")
        case 3:
            print("Delete Button Pressed")
        case 4:
            print("Uses Terms Button Pressed")
        default:
            print("Default")
        }
    }
    
    @objc func followButtonAction(sender: UIButton!) {
        sender.flash()
        following.toggle()
        if following{
            followButton.setTitle("Following", for: .normal)
        }else{
            followButton.setTitle("Follow", for: .normal)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if publishedButton.isEnabled{
            return 2
        }else{
            return 17
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        cell.title.text = "Theme \(indexPath.item+1)"
        
        let item = indexPath.item % 7
        cell.bg.image = UIImage(named: "wallpaper \(item+1)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: ", indexPath.item)
        let vc = storyboard?.instantiateViewController(identifier: "ThemeViewController") as! ThemeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-50)/3, height: ((view.frame.width-50)/3)*2.14876033)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = -topInset
        print("Offset: ", scrollView.contentOffset.y, topInset)
        if scrollView == mainScrollView{
            let newAlpha = 1 - (scrollView.contentOffset.y/offset)
            print("Alpha ",newAlpha)
            if newAlpha >= 0 && newAlpha <= 1{
                navigationView.alpha = newAlpha
            }else if newAlpha < 0{
                navigationView.alpha = 0
            }else{
                navigationView.alpha = 1
                optionStackView.isHidden = true
            }
        }
    }
}

extension UIView{
    func addBlurEffect(){
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            self.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            self.backgroundColor = .white
        }
    }
}
