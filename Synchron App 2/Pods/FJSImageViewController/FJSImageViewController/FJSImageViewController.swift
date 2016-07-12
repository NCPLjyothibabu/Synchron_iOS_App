//
//  FJSImageViewController.swift
//  FJSImageViewController
//
//  Created by hf on 2015/12/20.
//  Copyright © 2015年 swift-studing.com. All rights reserved.
//

import UIKit

public class FJSImageViewController: UIViewController {
    /** image to display */
    public var image: UIImage?
    /** Options to specify how a view adjusts its content when its size changes */
    public var contentMode: UIViewContentMode = .ScaleToFill
    /** Position and size of image */
    public var imageViewFrame: CGRect?
    
    private var isDirty = false;
    private let imageView = UIImageView(image: nil)
    private var beforePoint = CGPointMake(0.0, 0.0)
    private var currentScale = CGFloat(1.0)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImageView()
        setupGesture()
    }
    
    internal func handleGesture(gesture: UIGestureRecognizer){
        if let tapGesture = gesture as? UITapGestureRecognizer{
            tap(tapGesture)
        }else if let pinchGesture = gesture as? UIPinchGestureRecognizer{
            pinch(pinchGesture)
        }else if let panGesture = gesture as? UIPanGestureRecognizer{
            pan(panGesture)
        }
    }
    
    private func configureImageView(){
        self.imageView.image = image
        self.imageView.contentMode = contentMode
        self.imageView.frame = imageViewFrame ?? self.view.bounds
        self.imageView.userInteractionEnabled = true
        self.view.addSubview(self.imageView)
    }
    
    private func setupGesture(){
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "handleGesture:")
        self.view.addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleGesture:")
        self.view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "handleGesture:")
        self.view.addGestureRecognizer(panGesture)
    }
    
    private func pan(gesture:UIPanGestureRecognizer){
        isDirty = true
        
        var translation = gesture.translationInView(self.view)
        
        if abs(self.beforePoint.x) > 0.0 || abs(self.beforePoint.y) > 0.0{
            translation = CGPointMake(self.beforePoint.x + translation.x, self.beforePoint.y + translation.y)
        }
        
        switch gesture.state{
        case .Changed:
            let scaleTransform = CGAffineTransformMakeScale(self.currentScale, self.currentScale)
            let translationTransform = CGAffineTransformMakeTranslation(translation.x, translation.y)
            self.imageView.transform = CGAffineTransformConcat(scaleTransform, translationTransform)
        case .Ended , .Cancelled:
            self.beforePoint = translation
        default:
            break
        }
    }

    private func tap(gesture:UITapGestureRecognizer){
        if isDirty{
            isDirty = false
            UIView.animateWithDuration(0.2){
                self.beforePoint = CGPointMake(0.0, 0.0)
                self.imageView.transform = CGAffineTransformIdentity
            }
        }else{
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    private func pinch(gesture:UIPinchGestureRecognizer){
        var scale = gesture.scale
        scale = self.currentScale + (scale - 1.0)
        
        switch gesture.state{
        case .Changed:
            isDirty = true
            let scaleTransform = CGAffineTransformMakeScale(scale, scale)
            let transitionTransform = CGAffineTransformMakeTranslation(self.beforePoint.x, self.beforePoint.y)
            self.imageView.transform = CGAffineTransformConcat(scaleTransform, transitionTransform)
        case .Ended , .Cancelled:
            self.currentScale = scale
        default:
            break
        }
    }
}
