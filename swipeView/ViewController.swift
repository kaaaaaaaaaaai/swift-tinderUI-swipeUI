//
//  ViewController.swift
//  swipeView
//
//  Created by kai ogita on 2015/01/26.
//  Copyright (c) 2015年 kai ogita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var v = UIView()
    var snap2: UISnapBehavior?
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Makebox()
        
    }
    func Makebox(){
        self.v.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, self.view.bounds.size.height/2)
        self.v.center = self.view.center
        self.v.backgroundColor = UIColor.redColor()
        let myPan = UIPanGestureRecognizer(target: self, action: "dragged:")
        self.v.addGestureRecognizer(myPan)
        animator = UIDynamicAnimator(referenceView: view)
        self.view.addSubview(v)
        
        self.snap2 = UISnapBehavior(item: self.v, snapToPoint: CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    func dragged(sender: UIPanGestureRecognizer){
        
        var dragview = sender.view
        animator.removeAllBehaviors()
        if(sender.state == UIGestureRecognizerState.Ended){
            self.animator.addBehavior(self.snap2);
            
        }else{
            
            var delta: CGPoint = sender.translationInView(dragview!)
            var move: CGPoint = CGPointMake(dragview!.center.x + delta.x, dragview!.center.y + delta.y)
            println(dragview!.center.x)
            
            dragview!.center = move
            sender.setTranslation(CGPointZero, inView: dragview)
            if (dragview!.center.x < 60 || dragview!.center.x > 390) {
                self.v.removeFromSuperview()
                Makebox()
            }
        }
    }
    func snap(){
        animator.removeBehavior(snap2)
        var cent: CGPoint = CGPointMake(self.view.center.x, self.view.center.y)
        //println(self.view.center.x/2)
        snap2 = UISnapBehavior(item: self.v, snapToPoint: cent)
        animator.addBehavior(snap2)
        //println(snap2)
    }
}

