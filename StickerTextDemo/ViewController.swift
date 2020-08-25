//
//  ViewController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 27/04/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit
import AVFoundation

protocol ParentretrivalDelegate : AnyObject {
    var retriveParentController : ViewController {get}
}

class ViewController: UIViewController {

    @IBOutlet weak var btnPick  : UIButton!
    @IBOutlet weak var btnLayout  : UIButton!
    @IBOutlet weak var btnDesign  : UIButton!
    @IBOutlet weak var btnAnimation  : UIButton!
    @IBOutlet weak var ivPoster : UIImageView!
    
    @IBOutlet weak var containerView : UIView!
    
    
    var pageViewController      : UIPageViewController = UIPageViewController()
    var arrayViewControllers    : [UIViewController]   = []
    
    lazy var optionsCollections : [UIButton] = {
        return [btnLayout,btnDesign,btnAnimation]
    }()
    
    lazy var welcome2020 : PSStickerView = {
        let sticker = PSStickerView(frame: CGRect(x: 50, y: 150, width: 120, height: 60), textDM: attributeDM1)
        sticker.interactionDelegate = self
        return sticker
    }()

    lazy var attributeDM1 : TextLabelDM = {
        return TextLabelDM(text: "Welcome 2020",
                           font: UIFont.italicSystemFont(ofSize: 25.0),
                           textColor: .gradient(colors: [UIColor(hexString: "#AB3E00"),
                                                         UIColor(hexString: "#732A00")],
                                                orientation : GradientOrientation.horizontal(size: .zero)),
                           outlineColor: .gradient(colors: [UIColor(hexString: "#E67200"),
                                                            UIColor(hexString: "#FFFF00")],
                                                   orientation : GradientOrientation.topRightBottomLeft(size: .zero)),
                           outlineWidth: 5.0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivPoster.isUserInteractionEnabled = true 
        self.ivPoster.addSubview(welcome2020)
        self.setUpPageViewController()
        self.view.backgroundColor = .black
        
        btnLayoutClicked(btnLayout)
    }
    
    
    func setUpPageViewController() {
        
        let layoutController = LayoutCollectionController.loadController()
        layoutController.delegateLayoutSelection = self
        
        let designController = DesignContainerController.loadController()
        designController.delegateLabelUpdate = self
        
        let animationController = AnimationController.loadContoller()
        animationController.delegateAnimationController = self
        
        arrayViewControllers = [layoutController,designController, animationController]
        
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
    

    @IBAction func btnImageClicked(_ sender : UIButton) {
     
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func btnLayoutClicked(_ sender : UIButton) {
        
        stickerUserInteraction(enable: true)

        guard !sender.isSelected else {
            return
        }
        changeTabControl(sender, withAnimation: true)
        
    }

    @IBAction func btnAnimationClicked(_ sender : UIButton) {

        stickerUserInteraction(enable: false)
        guard !sender.isSelected else {
            return
        }
        
        changeTabControl(sender, withAnimation: true)
        
    }

    

    @IBAction func btnDesignClicked(_ sender : UIButton) {

        stickerUserInteraction(enable: true)

        guard !sender.isSelected else {
            return
        }
        
        changeTabControl(sender, withAnimation: true)
    }
    
    func changeTabControl(_ sender : UIButton, withAnimation animation : Bool) {
        
        arrayViewControllers.map({ itterativeController in
            (itterativeController as? AnimationProtocol)?.stopAnimation()
        })
        
        optionsCollections.select(sender)
        
        guard let index = optionsCollections.firstIndex(of: sender) else {
            return
        }

        self.pageViewController.setViewControllers([arrayViewControllers[index]],
                                                   direction: self.pageViewController.getScrollAnimation(index, arrayController: arrayViewControllers),
                                                   animated: animation,
                                                   completion: nil)
        
    }
    
    func stickerUserInteraction(enable : Bool) {
        
        if enable {
            welcome2020.isUserInteractionEnabled = true
            PSStickerView.setActiveStickerView(welcome2020)
        } else {
            welcome2020.isUserInteractionEnabled = false
            PSStickerView.setActiveStickerView(nil)
        }
        
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        ivPoster.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}

//---------------------------------------------------------
//MARK:- PSStickerViewInteractonDelegate

extension ViewController : PSStickerViewInteractonDelegate {
 
    func stickerView(_ sticker : PSStickerView, didDoubleTapForView interactionView : PSTextLabel) {

        let controller = AddTextViewController.loadController(textAnnonation: interactionView.lableDM!)

        controller.didDoneCompletion = { lableDM in
            interactionView.lableDM = lableDM
        }
        
        
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overFullScreen

        self.present(navigationController, animated: true, completion: nil)
    }
    
    func stickerViewTextEditOperationPerform(_ sticker : PSStickerView, withOptions options : Any?) {
        
    }
    func stickerViewResignResponder() {
        
    }
    
}

//---------------------------------------------------------
//MARK:-
extension ViewController : LayoutCollectionControllerDelegate {
    
    func layoutCollectionController(_ controller: LayoutCollectionController, didSelectLayout layout: TextLabelDM) {
     
        welcome2020.change(layout: layout)
        
    }
    
}

//---------------------------------------------------------
//MARK:- FontSelectionDelegate
extension ViewController : FontSelectionDelegate {

    func fontCollectionController(_ controller : FontCollectionController, didSelectFont font : UIFont) {
        welcome2020.change(font : font)
    }

}

//---------------------------------------------------------
//MARK:- TextStyleChangeDelegate

extension ViewController : TextStyleChangeDelegate {
    
    func textStyleController(_ controller: TextStyleController, didUpdateFontSize pointSize: Float) {
        welcome2020.change(pointSize: pointSize)
    }
    
    func textStyleController(_ controller: TextStyleController, didUpdateCharacterSpacing characterSpacing: Float) {
        welcome2020.change(characterSpacing: characterSpacing)
    }
    
    func textStyleController(_ controller: TextStyleController, didUpdateTextAligment textAlignment: Int) {
        welcome2020.change(textAlignment: textAlignment)
    }
    
    func textStyleController(_ controller: TextStyleController, didUpdateTextOpacity opacity: Float) {
        welcome2020.change(opacity: opacity)
    }
    
    func textStyleController(_ controller: TextStyleController, didUpdateTextColor color: ColorPattern) {
        welcome2020.change(textColor: color)
    }
    
}

//---------------------------------------------------------
//MARK:- TextOutlineChangedDelegate
extension ViewController : TextOutlineChangedDelegate {
    
    func outlineColorController(_ controller: OutlineColorController, didUpdateOutlineWidth width: Float) {
        
        welcome2020.change(outlineWidth: width)
    }
    
    func outlineColorController(_ controller: OutlineColorController, didUpdateOutlineColor color: ColorPattern) {
        welcome2020.change(outlineColor: color)
    }
}

//---------------------------------------------------------
//MARK:- ShadowColorDelegate
extension ViewController : ShadowColorDelegate {

    func shadowColorController(_ controller : ShadowColorController, didUpdateShadowOffset offset : Float){
        welcome2020.change(shadowOffset: offset)
    }
    
    func shadowColorController(_ controller : ShadowColorController, didUpdateShadowColor color : UIColor) {
        welcome2020.change(shadowColor: color)
    }

    func shadowColorController(_ controller : ShadowColorController, didUpdateShadowOpacity opacity : Float) {
        welcome2020.change(shadowOpacity: opacity)
    }
    
}

//---------------------------------------------------------
//MARK:-
extension ViewController : ParentretrivalDelegate {

    var retriveParentController: ViewController {
        return self
    }
}
