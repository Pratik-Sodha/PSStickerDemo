//
//  ShadowColorController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 06/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

protocol ShadowColorDelegate : AnyObject {
    func shadowColorController(_ controller : ShadowColorController, didUpdateShadowOffset offset : Float)
    func shadowColorController(_ controller : ShadowColorController, didUpdateShadowColor color : UIColor)
    func shadowColorController(_ controller : ShadowColorController, didUpdateShadowOpacity opacity : Float)
    
}

class ShadowColorController: UIViewController {

    //-----------------------------------------------------------------
    //MARK: - IBOutlet
    
    
    //-----------------------------------------------------------------
    //MARK: - Class Variable
    
    weak var delegateShadowDelegate : ShadowColorDelegate? = nil
    
    lazy var scrollView : UIScrollView = {
         let _scrollView = UIScrollView()
         return _scrollView
     }()
     
     lazy var verticalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [viewShadowSize,
                                                       viewShadowColor,
                                                       viewShadowOpcity])
         stackView.axis = .vertical
         stackView.distribution = .fillEqually
         return stackView
     }()
    
    //---------------------------------------------------------
       lazy var viewShadowSize : IconContainerView = {
           let view = IconContainerView(R.image.iconTextOutlineSelection())
           return view
       }()
       
       lazy var shadowSizeSlider: Slider = {
           let slider = Slider(initialValue: 5.0,minimumValue: 0.0, maximumValue: 10.0)
           slider.valueChangedCompletion = { value in
            self.delegateShadowDelegate?.shadowColorController(self, didUpdateShadowOffset: value)
           }
           return slider
       }()
       
       //---------------------------------------------------------
       lazy var viewShadowColor : IconContainerView = {
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
       
    var colorDataSource : [ColorPattern] = []
    
    //---------------------------------------------------------
    
    lazy var viewShadowOpcity: IconContainerView = {
        let view = IconContainerView(R.image.iconOpacity())
        return view
    }()
    
    lazy var opacitySlider : Slider = {
        let slider = Slider(initialValue: 0.5, minimumValue: 0.0, maximumValue: 1)
        slider.valueChangedCompletion = { value in
            self.delegateShadowDelegate?.shadowColorController(self, didUpdateShadowOpacity: value)
        }
        return slider
    }()
    
    //-----------------------------------------------------------------
    //MARK: - Custom Method
         func setUpView() {
         
         setUpSubviews()
     }
     
     func setUpSubviews() {

        /**
         Add Some plain color
         */

        colorDataSource.append(contentsOf: [
            ColorPattern.plain(color: .white),
            ColorPattern.plain(color: .black),
            ColorPattern.plain(color: .red),
            ColorPattern.plain(color: .yellow),
            ColorPattern.plain(color: .green),
            ColorPattern.plain(color: .blue),
            ColorPattern.plain(color: .purple),
            ColorPattern.plain(color: .gray),
            ColorPattern.plain(color: .lightGray),
            ColorPattern.plain(color: .darkGray),
        ])
        
        view.addSubview(scrollView)
         scrollView.addSubview(verticalStackView)

        viewShadowSize.prepareContainerView(view: shadowSizeSlider)
        viewShadowColor.prepareContainerView(view: colorCollectionView)
        viewShadowOpcity.prepareContainerView(view: opacitySlider)


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
         
         shadowSizeSlider.snp.makeConstraints { (make) in
             make.edges.equalToSuperview().inset(10)
         }

        colorCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.leading.equalTo(10)
        }
        
        opacitySlider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }

     }
    
    //-----------------------------------------------------------------
    //MARK: - Action Method
    
    
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
    
    static func loadController() -> ShadowColorController { return ShadowColorController()}
}

//---------------------------------------------------------
//MARK:-
extension ShadowColorController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let color = colorDataSource[indexPath.row].colorValue()
        self.delegateShadowDelegate?.shadowColorController(self, didUpdateShadowColor: color)
    }

}
