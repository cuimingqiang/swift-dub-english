//
//  CBannerView.swift
//  dub
//
//  Created by cuimingqiang on 16/1/30.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import UIKit

@objc protocol CBannerViewDelegate{
    optional func didSelectItem(item : Int)
}
@objc protocol CBannerViewDataSource{
    func numberOfItems() -> Int
    func bannerView(bannerView : CBannerView , index:Int) -> UIView
}
class CBannerView: UIView ,UIGestureRecognizerDelegate{
    var width : CGFloat!
    var height : CGFloat!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.width = frame.width
        self.height = frame.height
 
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(" not impl")
    }

//    override func touchesMoved(var touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch =  touches.popFirst()
//        let point =  touch?.locationInView(self)
//        let position = nextPosition((point?.x)!)
//    }

    private func nextPosition(x : CGFloat) -> Int{

        return 0
    }
    func handleSwipGesture(){
        print("---")
    }
}
