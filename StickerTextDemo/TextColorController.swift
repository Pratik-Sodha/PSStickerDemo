//
//  TextStyleController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 05/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

protocol TextStyleChangeDelegate : AnyObject {
    func textStyleController(_ controller : TextStyleController, didUpdateFontSize pointSize : Float)
    func textStyleController(_ controller : TextStyleController, didUpdateCharacterSpacing characterSpacing : Float)
    func textStyleController(_ controller : TextStyleController, didUpdateTextAligment textAlignment : Int)
    func textStyleController(_ controller : TextStyleController, didUpdateTextOpacity opacity : Float)
    func textStyleController(_ controller : TextStyleController, didUpdateTextColor color : ColorPattern)
}

class TextStyleController: UIViewController {

    //-----------------------------------------------------------------
    //MARK: - Class Variable
    lazy var scrollView : UIScrollView = {
        let _scrollView = UIScrollView()
        return _scrollView
    }()
    
    lazy var verticalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [viewFontSize,
                                                       viewTextColor,
                                                       viewCharacterSpacing,
                                                       viewTextAlginment,
                                                       viewLabelOpcity])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    //---------------------------------------------------------
    lazy var viewFontSize: IconContainerView = {
        let view = IconContainerView(R.image.iconFontSize())
        return view
    }()
    
    lazy var fontSizeSlider: Slider = {
        let slider = Slider(initialValue: 25.0,minimumValue: 8.0, maximumValue: 72.0)
        slider.valueChangedCompletion = { value in
            self.delegateTextStyle?.textStyleController(self, didUpdateFontSize: value)
        }
        return slider
    }()

    //---------------------------------------------------------
    lazy var viewTextColor: IconContainerView = {
        let view = IconContainerView(R.image.iconColor())
        return view
    }()
   
    lazy var colorCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ColorPickerCollectionCell.self, forCellWithReuseIdentifier: ColorPickerCollectionCell.cellIdentifier)
        return collectionView
    }()
    
    lazy var collectionViewFlowLayout :  UICollectionViewFlowLayout  = {
       let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 2)
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 2
        return layout
    }()
    
    //---------------------------------------------------------
    
    lazy var viewCharacterSpacing: IconContainerView = {
        let view = IconContainerView(R.image.iconCharacterSpacing())
        return view
    }()
    
    lazy var characterSpacingSlider : Slider = {
        let slider = Slider(initialValue: 0, minimumValue: 0, maximumValue: 10)
        slider.valueChangedCompletion = { value in
            self.delegateTextStyle?.textStyleController(self, didUpdateCharacterSpacing: value)
        }
        return slider
    }()

    //---------------------------------------------------------
    
    lazy var viewTextAlginment: IconContainerView = {
        let view = IconContainerView(R.image.iconAlignment())
        return view
    }()
    
    lazy var btnLeft : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.leftAlignment(), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(btnLeftClicked(_:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy var btnCenter : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.centerAlignment(), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(btnCenterClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var btnRight : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.rightAlignment(), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(btnRightClicked(_:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    lazy var alignmentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [btnLeft,
                                                       btnCenter,
                                                       btnRight])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    let colorDataSource = ColorPattern.dataSoure
    
    //---------------------------------------------------------
    
    lazy var viewLabelOpcity: IconContainerView = {
        let view = IconContainerView(R.image.iconOpacity())
        return view
    }()
    
    lazy var opacitySlider : Slider = {
        let slider = Slider(initialValue: 1, minimumValue: 0.03, maximumValue: 1)
        slider.valueChangedCompletion = { value in
            self.delegateTextStyle?.textStyleController(self, didUpdateTextOpacity: value)
        }
        return slider
    }()
    
    
    //---------------------------------------------------------

    weak var delegateTextStyle : TextStyleChangeDelegate? = nil
    
    //-----------------------------------------------------------------
    //MARK: - Custom Method
    
    func setUpView() {
        
        setUpSubviews()
    }
    
    func setUpSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)

        viewFontSize.prepareContainerView(view: fontSizeSlider)
        viewTextColor.prepareContainerView(view: colorCollectionView)
        viewCharacterSpacing.prepareContainerView(view: characterSpacingSlider)
        viewTextAlginment.prepareContainerView(view: alignmentStackView)
        viewLabelOpcity.prepareContainerView(view: opacitySlider)

        makeConstraints()
    }
    let viewHeight = 45
    func makeConstraints() {


        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(verticalStackView.arrangedSubviews.count * viewHeight)
            make.bottom.equalToSuperview().priority(250)
        }
        
        fontSizeSlider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
        characterSpacingSlider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
        alignmentStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
        opacitySlider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }

        colorCollectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(10)
            make.top.bottom.trailing.equalToSuperview()
        }
        
    }
    //-----------------------------------------------------------------
    //MARK: - Action Method
    @objc func btnLeftClicked(_ sender : UIButton) {
        delegateTextStyle?.textStyleController(self, didUpdateTextAligment: 0)
    }
    
    @objc func btnCenterClicked(_ sender : UIButton) {
        delegateTextStyle?.textStyleController(self, didUpdateTextAligment: 1)
    }
    
    @objc func btnRightClicked(_ sender : UIButton) {
        delegateTextStyle?.textStyleController(self, didUpdateTextAligment: 2)
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
    
    static func loadController() -> TextStyleController { return TextStyleController()}

}

//---------------------------------------------------------
//MARK:-
extension TextStyleController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickerCollectionCell.cellIdentifier,
                                                      for: indexPath) as! ColorPickerCollectionCell

        cell.color = colorDataSource[indexPath.row]

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height - 6
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateTextStyle?.textStyleController(self, didUpdateTextColor: colorDataSource[indexPath.row])
    }

}
