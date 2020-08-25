//
//  DesignContainerController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

class DesignContainerController: UIViewController {

    //-----------------------------------------------------------------
    //MARK: - IBOutlet
    
    
    //-----------------------------------------------------------------
    //MARK: - Class Variable
    weak var delegateLabelUpdate : (FontSelectionDelegate & TextStyleChangeDelegate & TextOutlineChangedDelegate & ShadowColorDelegate)? = nil

    lazy var oprtionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        return stackView
    }()

    lazy var containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var btnFont : UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(btnFontClicked(_:)), for: .touchUpInside)
        button.setImage(R.image.iconFont(), for: .normal)
        button.setImage(R.image.iconFontSelection(), for: .selected)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        return button
    }()
    
    lazy var btnTextColor : UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(btnTextColorClicked(_:)), for: .touchUpInside)
        button.setImage(R.image.iconTextColor(), for: .normal)
        button.setImage(R.image.iconTextColorSelection(), for: .selected)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        return button
    }()
    
    lazy var btnTextOutline : UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(btnTextOutlineClicked(_:)), for: .touchUpInside)
        button.setImage(R.image.iconTextOutline(), for: .normal)
        button.setImage(R.image.iconTextOutlineSelection(), for: .selected)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        return button
    }()
    
    lazy var btnTextShadow : UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(btnTextShadowClicked(_:)), for: .touchUpInside)
        button.setImage(R.image.iconTextShadow(), for: .normal)
        button.setImage(R.image.iconTextShadowSelection(), for: .selected)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        return button
    }()
    
    lazy var optionsCollections : [UIButton] = {
        return [btnFont,btnTextColor,btnTextOutline,btnTextShadow]
    }()
    
    var pageViewController      : UIPageViewController = UIPageViewController()
    var arrayViewControllers    : [UIViewController]   = []
    
    //-----------------------------------------------------------------
    //MARK: - Custom Method
    
    func setUpView() {
        view.backgroundColor = .black
        setUpSubviews()
        setUpPageViewController()
        self.changeTabControl(btnFont, withAnimation: false)
    }

    func setUpSubviews() {
        oprtionsStackView.addArrangedSubviews(optionsCollections)
        view.addSubview(oprtionsStackView)
        view.addSubview(containerView)
        makeConstraints()
        
    }
    
    func makeConstraints() {
        oprtionsStackView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(oprtionsStackView.snp.bottom)
        }
    }
    
    func setUpPageViewController() {
        
        let fontController = FontCollectionController.loadControlelr()
        fontController.delegateFontSelection = self.delegateLabelUpdate
        
        let textStyleController = TextStyleController.loadController()
        textStyleController.delegateTextStyle = self.delegateLabelUpdate

        let textOutlineController = OutlineColorController.loadController()
        textOutlineController.delegateOutlineChange = self.delegateLabelUpdate

        let textShadowController = ShadowColorController.loadController()
        textShadowController.delegateShadowDelegate = self.delegateLabelUpdate

        arrayViewControllers = [fontController,textStyleController,textOutlineController,textShadowController]
        
        //page Controller setup
        self.pageViewController = UIPageViewController(transitionStyle: .scroll
            , navigationOrientation: .horizontal
            , options: nil)
        
        self.pageViewController.setViewControllers([self.arrayViewControllers[0]], direction: .forward, animated: true, completion: nil)
        self.addChild(self.pageViewController)
        self.containerView.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        
        self.pageViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //-----------------------------------------------------------------
    //MARK: - Action Method
    
    @IBAction func btnFontClicked(_ sender : UIButton) {
        guard !sender.isSelected else {
            return
        }
        self.changeTabControl(sender, withAnimation: true)
    }
    
    @IBAction func btnTextColorClicked(_ sender : UIButton) {
        guard !sender.isSelected else {
            return
        }
        self.changeTabControl(sender, withAnimation: true)
    }
    
    @IBAction func btnTextOutlineClicked(_ sender : UIButton) {
        guard !sender.isSelected else {
            return
        }
        self.changeTabControl(sender, withAnimation: true)
    }
    
    @IBAction func btnTextShadowClicked(_ sender : UIButton) {
        guard !sender.isSelected else {
            return
        }
        self.changeTabControl(sender, withAnimation: true)
    }
    
    func changeTabControl(_ sender : UIButton, withAnimation animation : Bool) {
        
        optionsCollections.select(sender)
        
        guard let index = optionsCollections.firstIndex(of: sender) else {
            return
        }

        self.pageViewController.setViewControllers([arrayViewControllers[index]],
                                                   direction: self.pageViewController.getScrollAnimation(index, arrayController: arrayViewControllers),
                                                   animated: animation,
                                                   completion: nil)
        
    }
    //-----------------------------------------------------------------
    //MARK: - Delegate Method
    
    
    //-----------------------------------------------------------------
    //MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("DidReceiveMemoryWarning....")
    }
    
    deinit {
        
    }
    
    //-----------------------------------------------------------------
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        
    }
    
    static func loadController() -> DesignContainerController {return DesignContainerController()}

}
//---------------------------------------------------------
//MARK:-
extension Array where Element : UIButton {
    
    func select(_ control : UIControl) {
        _ = self.map { (_itteration) -> Void in
            _itteration.isSelected = false
        }
        control.isSelected = true
    }
    
}
