//
//  PopupSearchMenu.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit

class PopupSearchMenu: UIView {
  
  //MARK: - Properties
  
  @IBOutlet weak var textField: UITextField!
  weak var searchMenuDelegate:PopupSearchMenuDelegate?
  
  
  //MARK: - Constants
  let cornerRadiusConst:CGFloat = 10
  var screenWidth:CGFloat = 0
  var screenHeight:CGFloat = 0
  let backColorConst = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
  let backgroundColorConts = UIColor(red: 240.0/255, green: 240.0/255, blue: 240.0/255, alpha: 1.0)
  var backView:UIView = UIView()
  var mainFrame:CGRect = CGRect.zero
  var defaultFrame:CGRect = CGRect.zero
  let widthInsetConst:CGFloat = 15
  let navBarHeightConst:CGFloat = 64
  
  //MARK: - Functions
  override init (frame: CGRect) {
    super.init(frame: frame)
    mainFrame = frame
    commonSetup()
    addFunctionality()
  }
  
  convenience init () {
    self.init(frame:CGRect.zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    let screenRect:CGRect = UIScreen.main.bounds
    screenWidth = screenRect.size.width
    screenHeight = screenRect.size.height
    mainFrame = CGRect(x:widthInsetConst,
                       y:screenHeight / 2 - frame.size.height / 2 + navBarHeightConst/2,
                       width:   screenWidth - 2 * widthInsetConst,
                       height: frame.size.height)
    addFunctionality()
  }
  
  func dismiss() {
    UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
      
      self.backView.alpha = 0
    }) { _ in self.backView.removeFromSuperview()
      self.layoutIfNeeded() }
  }
  
  func show(superView:UIView?, viewController: UIViewController) {
    searchMenuDelegate = viewController as? PopupSearchMenuDelegate
    if let superViewX = superView {
      superViewX.addSubview(self.backView)
    }
    backView.frame = CGRect(x:0, y:0, width: screenWidth, height:screenHeight)
    backView.alpha = 0
    textField.text = UserDefaults.standard.getSearchString()
    
    UIView.animate(withDuration: 0.9, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
      self.backView.alpha = 1
    }) { _ in self.layoutIfNeeded() }
  }
  
  func commonSetup() {
    let nibView:UIView = loadViewFromNib()
    nibView.frame = bounds
    nibView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    addSubview(nibView)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: classForCoder)
    let view:UIView = bundle.loadNibNamed(NSStringFromClass(classForCoder), owner:self, options:nil)![0] as! UIView
    return view
  }
  
  //MARK: - Add background view
  
  func addFunctionality() {
    let screenRect:CGRect = UIScreen.main.bounds
    screenWidth = screenRect.size.width
    screenHeight = screenRect.size.height
    
    backView.frame = CGRect(x:screenWidth, y:screenHeight, width:screenWidth, height:screenHeight)
    backView.backgroundColor = backColorConst
    backView.clipsToBounds = true
    
    frame = mainFrame
    layer.cornerRadius = cornerRadiusConst
    clipsToBounds = true
    backView.addSubview(self)
  }
  
  
  //MARK: - functional buttons with protocol
  
  @IBAction func searchButtonAction(_ sender: UIButton) {
    if let delegate = searchMenuDelegate {
      if textField.text != "" {
        UserDefaults.standard.saveSearchString(sString: textField.text!)
        delegate.searchPressed(additional: "", serachName: textField.text!)
        dismiss()
      } else {
        delegate.searchPressed(additional: "empty", serachName: "")
      }
    }
  }
  
  @IBAction func closeAction(_ sender: UIButton) {
    if let delegate = searchMenuDelegate {
      delegate.dismissPressed()
      dismiss()
    }
  }
  
  
}

protocol PopupSearchMenuDelegate: class {
  func searchPressed(additional:String, serachName:String)
  func dismissPressed()
}
