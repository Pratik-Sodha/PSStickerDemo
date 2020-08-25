//
//  LayoutCollectionController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 04/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit
import SnapKit

protocol LayoutCollectionControllerDelegate : AnyObject {
    func layoutCollectionController(_ controller : LayoutCollectionController, didSelectLayout layout : TextLabelDM)
}


class LayoutCollectionController: UIViewController {

    //-----------------------------------------------------------------
    //MARK: - IBOutlet
    
    weak var delegateLayoutSelection : LayoutCollectionControllerDelegate? = nil
    
    lazy var collectionView : UICollectionView = {
        let _collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.showsVerticalScrollIndicator = false
        _collectionView.register(LayoutCollectionCell.self, forCellWithReuseIdentifier: "LayoutCollectionCell")
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
    lazy var dataSource : [TextLabelDM] = {
        return TextLabelDM.dataSource
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
    
    static func loadController() -> LayoutCollectionController { return LayoutCollectionController() }
    
}

extension LayoutCollectionController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayoutCollectionCell", for: indexPath) as! LayoutCollectionCell
        cell.lblDM = dataSource[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let count : CGFloat = 5.0
        let width = (collectionView.frame.width - (10.0 * (count + 1))) / count
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegateLayoutSelection?.layoutCollectionController(self, didSelectLayout: dataSource[indexPath.row])
    }

}
