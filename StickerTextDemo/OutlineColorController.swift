//
//  OutlineColorController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 06/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit

protocol TextOutlineChangedDelegate : AnyObject{
    func outlineColorController(_ controller : OutlineColorController, didUpdateOutlineWidth width : Float)
    func outlineColorController(_ controller : OutlineColorController, didUpdateOutlineColor color : ColorPattern)
}

class OutlineColorController: UIViewController {

    //-----------------------------------------------------------------
    //MARK: - IBOutlet
    
    
    //-----------------------------------------------------------------
    //MARK: - Class Variable
    //-----------------------------------------------------------------
    weak var delegateOutlineChange : TextOutlineChangedDelegate? = nil

    //MARK: - Class Variable
       lazy var scrollView : UIScrollView = {
           let _scrollView = UIScrollView()
           return _scrollView
       }()
       
       lazy var verticalStackView : UIStackView = {
           let stackView = UIStackView(arrangedSubviews: [viewOutlineSize,
                                                          viewOutlineColor])
           stackView.axis = .vertical
           stackView.distribution = .fillEqually
           return stackView
       }()
    
    //---------------------------------------------------------
    lazy var viewOutlineSize : IconContainerView = {
        let view = IconContainerView(R.image.iconTextOutlineSelection())
        return view
    }()
    
    lazy var outlineSizeSlider: Slider = {
        let slider = Slider(initialValue: 5.0,minimumValue: 0.0, maximumValue: 30.0)
        slider.valueChangedCompletion = { value in
            self.delegateOutlineChange?.outlineColorController(self, didUpdateOutlineWidth: value)
        }
        return slider
    }()
    
    //---------------------------------------------------------
    lazy var viewOutlineColor : IconContainerView = {
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
    
    var colorDataSource = ColorPattern.dataSoure
    //-----------------------------------------------------------------
    //MARK: - Custom Method
    
      func setUpView() {
         
         setUpSubviews()
     }
     
     func setUpSubviews() {

        /**
         Add Some plain color
         */

        colorDataSource.insert(contentsOf:
            [
                ColorPattern.plain(color: .red),
                ColorPattern.plain(color: .yellow),
                ColorPattern.plain(color: .green),
                ColorPattern.plain(color: .blue),
                ColorPattern.plain(color: .purple),
                ColorPattern.plain(color: .gray),
                ColorPattern.plain(color: .lightGray),
                ColorPattern.plain(color: .darkGray),
        ], at: 2)
        
        view.addSubview(scrollView)
         scrollView.addSubview(verticalStackView)

        viewOutlineSize.prepareContainerView(view: outlineSizeSlider)
        viewOutlineColor.prepareContainerView(view: colorCollectionView)


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
         
         outlineSizeSlider.snp.makeConstraints { (make) in
             make.edges.equalToSuperview().inset(10)
         }

        colorCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.leading.equalTo(10)
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
    
    static func loadController() -> OutlineColorController { return OutlineColorController() }
    
}

//---------------------------------------------------------
//MARK:-
extension OutlineColorController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        delegateOutlineChange?.outlineColorController(self, didUpdateOutlineColor: colorDataSource[indexPath.row])
    }

}
