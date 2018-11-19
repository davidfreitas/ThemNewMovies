//
//  LoaderView.swift
//
//
//  Created by David Freitas on 18/11/18.
//  Copyright © 2015 David Freitas. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    // -----
    // Helper class that shows an activity indicator on the screen
    // -----
    
    private static var instance: LoaderView?
    
    private let activityView = UIActivityIndicatorView()
    private var removing: Bool = false
    
    private class func getInstance() -> LoaderView {
        if instance == nil {
            instance = LoaderView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        }
        
        return instance!
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupActivityIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    }
    
    private func setupActivityIndicator() {
        activityView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityView)
        
        // set constraints
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    class func show(inViewController viewController: UIViewController) {
        show(inView: viewController.view)
    }
    
    class func show(inView view: UIView) {
        let instance = getInstance()
        
        instance.removing = false
        instance.activityView.startAnimating()
        
        view.addSubview(instance)
        
        // set constraints
        instance.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        instance.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        instance.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instance.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // fade in
        UIView.animate(withDuration: 0.3, animations: { [weak instance] in
            instance?.alpha = 1.0
        })
    }
    
    class func hide() {
        guard let instance = instance else {
            return
        }
        
        instance.removing = true
        
        // fade out
        UIView.animate(withDuration: 0.3, animations: { [weak instance] () -> Void in
            instance?.alpha = 0.0
            }, completion: { [weak instance] (finished) -> Void in
                if let instance = instance, instance.removing {
                    instance.activityView.stopAnimating()
                    instance.removeFromSuperview()
                }
        }) 
    }
}
