//
//  AddTextViewController.swift
//  StickerTextDemo
//
//  Created by SOTSYS151 on 04/05/20.
//  Copyright © 2020 Debugger. All rights reserved.
//

import UIKit
import SnapKit

class AddTextViewController: UIViewController {


    //-----------------------------------------------------------------
    //MARK: - Class Variable
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 17.0)
        tv.textColor = .white
        tv.textAlignment = .center
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var leftBarCancelButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(leftBarCancelButtonClicked(_:)))
        return button
    }()
    
    lazy var rightBarDoneButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(rightBarDoneButtonClicked(_:)))
        return button
    }()
    
    var attributes : TextLabelDM!
    var didDoneCompletion : ((TextLabelDM) -> Void)? = nil


    //-----------------------------------------------------------------
    //MARK: - Custom Method
    
    func setUpView() {

        self.view.backgroundColor = .clear

        self.navigationItem.leftBarButtonItems = [leftBarCancelButton]
        self.navigationItem.rightBarButtonItems = [rightBarDoneButton]
        
        containerView.addSubview(visualEffectView)
        containerView.addSubview(textView)

        self.view.addSubview(containerView)

        self.makeConstraints()
        
        self.addObserver()

        self.textView.becomeFirstResponder()
        self.textView.text = attributes.text
    }

    //---------------------------------------------------------
    //MARK:- Notification Methods
    func addObserver() {

        textView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserver() {
        textView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if let _textView = object as? UITextView {
            var topCorrect = (_textView.frame.size.height - _textView.contentSize.height * _textView.zoomScale) / 2.0
            topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
            _textView.contentInset = UIEdgeInsets(top: topCorrect, left: 0, bottom: 0, right: 0)

        }
    }

    @objc func keyboardWillShowNotification(_ notification : NSNotification) {
        
        guard let info = notification.userInfo else { return }
        guard let frameInfo = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = frameInfo.cgRectValue

        bottomConstraint.update(offset: -keyboardFrame.height)
        self.updateFocusIfNeeded()
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHideNotification(_ notification : NSNotification) {

        bottomConstraint.update(offset: 0)

        self.updateFocusIfNeeded()

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    var bottomConstraint : Constraint!
    func makeConstraints() {
        
        visualEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(UIEdgeInsets(top: 44,
                                                           left: 10,
                                                           bottom: 10,
                                                           right: 10))
            make.leading.trailing.bottom.equalToSuperview()

        }

        
        containerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            bottomConstraint = make.bottom.equalToSuperview().constraint
        }

    }
    
    //-----------------------------------------------------------------
    //MARK: - Action Method
    @objc func rightBarDoneButtonClicked(_ sender : UIBarButtonItem) {
        attributes.text = textView.text
        didDoneCompletion?(attributes)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func leftBarCancelButtonClicked(_ sender : UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
        self.removeObserver()
    }
    
    //-----------------------------------------------------------------
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        
    }
    
    class func loadController(textAnnonation : TextLabelDM) -> AddTextViewController {
        let controller = AddTextViewController()
        controller.attributes = textAnnonation
        return controller
    }

}
