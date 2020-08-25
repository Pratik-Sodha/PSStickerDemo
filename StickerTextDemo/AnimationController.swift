//
//  AnimationController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 08/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit
import AVKit

protocol AnimationProtocol : AnyObject {
    func stopAnimation()
}

class AnimationController: UIViewController {

    //-----------------------------------------------------------------
    //MARK: - IBOutlet
    lazy var collectionView : UICollectionView = {
           let _collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
           _collectionView.delegate = self
           _collectionView.dataSource = self
           _collectionView.showsVerticalScrollIndicator = false
           _collectionView.register(AnimationCollectionCell.self, forCellWithReuseIdentifier: "AnimationCollectionCell")
           _collectionView.backgroundColor = .black
           return _collectionView
       }()

       lazy var collectionViewFlowLayout :  UICollectionViewFlowLayout  = {
          let layout = UICollectionViewFlowLayout()
           layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
           layout.minimumLineSpacing = 10
           layout.minimumInteritemSpacing = 5
           return layout
       }()
    
    //-----------------------------------------------------------------
    //MARK: - Class Variable
    weak var delegateAnimationController : (ParentretrivalDelegate)? = nil
    
    lazy var dataSource : [AnimationDM] = {
        return AnimationDM.dataSource
    }()
    //-----------------------------------------------------------------
    //MARK: - Custom Method
    
    func setUpView() {
        
        setUpSubviews()
    }
    
    func setUpSubviews() {
        self.view.addSubview(collectionView)
        makeConstraints()
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation(atIndex: selectedIndex)
    }
    
    var selectedIndex : Int {
        
        guard let index = (dataSource.firstIndex { (dm) -> Bool in
            return dm.isSelected
        }) else {
            return 0
        }
        return index
    }
    
    func startAnimation(atIndex index : Int) {

        let dataAtIndex = dataSource[index]

        dataSource.deselectAll()
        dataAtIndex.isSelected = true
        self.collectionView.reloadData()

        guard let welcome2020 = delegateAnimationController?.retriveParentController.welcome2020 else {
            return
        }
        itterativeLayer?.removeFromSuperlayer()
        itterativeLayer = welcome2020.operationalLayer()
        
        
        guard let textLayer = itterativeLayer else {
            return
        }
        welcome2020.superview?.layer.addSublayer(textLayer)
        /*
         
         let fadeTransition = CATransition()
         fadeTransition.duration = 3.0
         
         CATransaction.begin()
         CATransaction.setCompletionBlock({
         welcome2020.label.alpha = 1.0
         welcome2020.label.layer.add(fadeTransition, forKey: kCATransition)
         })
         
         welcome2020.label.alpha = 0.1
         welcome2020.label.layer.add(fadeTransition, forKey: kCATransition)
         
         CATransaction.commit()
         
         */
        
        
        guard let animation = dataAtIndex.animation.getAnimation(
               layer: textLayer,
               layerRect: textLayer.frame,
               containerView: welcome2020.superview!) else
        {
            print("return")
            return
        }
        welcome2020.change(animation: animation)
        textLayer.add(animation, forKey: dataAtIndex.keyPath)
        
        
    }
    
    
    static func loadContoller() -> AnimationController { return AnimationController()}
    
    var itterativeLayer : CALayer!
}

extension AnimationController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimationCollectionCell", for: indexPath) as! AnimationCollectionCell
        cell.animationDM = dataSource[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let count : CGFloat = 3.0
        let width = (collectionView.frame.width - (10.0 * (count + 1))) / count
        return CGSize(width: width, height: width - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dataAtIndex = dataSource[indexPath.row]
        
        guard !dataAtIndex.isSelected else {
            return
        }
        startAnimation(atIndex: indexPath.row)
    }
}


extension AnimationController : AnimationProtocol {
    func stopAnimation() {
        itterativeLayer?.removeFromSuperlayer()
    }
}

