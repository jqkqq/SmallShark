//
//  UIView+Draggable.swift
//
//  Created by Yehia Elbehery on 1/10/19.
//  Copyright © 2019 Yehia Elbehery. All rights reserved.
//

import UIKit

extension UIView {
    func addDragging(){
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    var fullscreenSize:CGSize{
        return UIScreen.main.bounds.size
    }
    @objc private func draggedAction(_ pan:UIPanGestureRecognizer){
        
        let translation = pan.translation(in: self.superview)
        let x = self.center.x + translation.x
        let y = self.center.y + translation.y
        if x > fullscreenSize.width-20 || x < 30 || y > fullscreenSize.height-80 || y < 30 {
            return
        }
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        pan.setTranslation(CGPoint.zero, in: self.superview)
    }
}
