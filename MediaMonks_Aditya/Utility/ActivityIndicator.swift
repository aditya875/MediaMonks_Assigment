//
//  ActivityIndicator.swift
//

import UIKit
import ImageIO

fileprivate var indicators: [UIView:UIView] = [:]

extension UIView
{
    func startActivityIndicator()
    {
        if indicators[self] == nil
        {
            configure(view: self)
        }
    }
    
    func stopActivityIndicator()
    {
        if let view = indicators[self]
        {
            view.removeFromSuperview()
            indicators[self] = nil
        }
    }
}

fileprivate func configure(view: UIView)
{
    /*if let _view = view.viewWithTag(Int.max) {
        _view.removeFromSuperview()
    }
    
    if view.bounds.size.height < ScreenSizes.SCREEN_HEIGHT {
        let indicator = MKNSpinner()//(frame: CGRect(x: 0,y: 0,width: 70,height: 70))
        indicator.show(title: "Fetching..", animated: false, viewForSpinner: view)
        indicator.startAnimating()
        indicators[view] = indicator
        return
    }*/
    
    let _uiview_activityIndicator = UIView(frame: CGRect(x: 0,y: 0,width: 70,height: 70))
    _uiview_activityIndicator.clipsToBounds = false
    _uiview_activityIndicator.layer.masksToBounds = false
    _uiview_activityIndicator.layer.shadowOpacity = 1.0
    _uiview_activityIndicator.layer.cornerRadius = 5
    _uiview_activityIndicator.tag = Int.max
    _uiview_activityIndicator.layer.shadowOffset = CGSize(width: 0, height: 3)
    _uiview_activityIndicator.layer.shadowColor = UIColor.darkGray.cgColor
    _uiview_activityIndicator.backgroundColor = UIColor.clear

    
    /*let indicator = MKNSpinner(frame: _uiview_activityIndicator.bounds)
    indicator.startAnimating()*/
    let indicator = UIActivityIndicatorView(frame: _uiview_activityIndicator.bounds)
    indicator.style = UIActivityIndicatorView.Style.medium
    indicator.startAnimating()
    
    _uiview_activityIndicator.addSubview(indicator)
    indicators[view] = _uiview_activityIndicator
    view.addSubview(_uiview_activityIndicator)
    _uiview_activityIndicator.center = view.center
}



// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}
