//
//  LoaderView.swift
//
//
//  Created by David Freitas on 12/16/15.
//  Copyright © 2015 David Freitas. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    static let instance: LoaderView = LoaderView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    let activityView = UIActivityIndicatorView()
    var removing: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityView)
        
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.alpha = 1.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func show() {
        instance.removing = false
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController!
        
        while let presentedViewController = rootViewController?.presentedViewController {
            rootViewController = presentedViewController
        }
        
        self.show(rootViewController!)
    }
    
    static func show(_ viewController: UIViewController) {
        instance.removing = false
        instance.activityView.startAnimating()

        let rootView = viewController.view
        rootView!.addSubview(instance)
        
        instance.topAnchor.constraint(equalTo: rootView!.topAnchor).isActive = true
        instance.bottomAnchor.constraint(equalTo: rootView!.bottomAnchor).isActive = true
        instance.leadingAnchor.constraint(equalTo: rootView!.leadingAnchor).isActive = true
        instance.trailingAnchor.constraint(equalTo: rootView!.trailingAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            instance.alpha = 1.0
        })
    }
    
    static func hide() {
        instance.removing = true
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            instance.alpha = 0.0
            }, completion: { (finished) -> Void in
                if instance.removing {
                instance.activityView.stopAnimating()
                instance.removeFromSuperview()
                }
        }) 
    }
}
