//
//  HomeItemViewCell.swift
//  dub
//
//  Created by admin on 16/2/2.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class HomeItemViewCell: UITableViewCell {
    lazy var imgs = [UIImageView.init(),UIImageView.init(),UIImageView.init(),UIImageView.init()]
    lazy var titles = [UILabel.init(),UILabel.init(),UILabel.init(),UILabel.init()]
    lazy var numbers = [UILabel.init(),UILabel.init(),UILabel.init(),UILabel.init()]
    @IBOutlet weak var body: UIView!
    func reLayout(){
        for i in 0..<imgs.count{
            let img = imgs[i]
//            img.image = UIImage.init(named: "img_activity_head")
            img.sd_setImageWithURL(nil, placeholderImage: UIImage.init(named: "img_activity_head"))
            body.addSubview(img)
            img.snp_makeConstraints {
                $0.width.equalTo(body).dividedBy(2).offset(-5)
                $0.height.equalTo(100)
                if i % 2 == 0 {
                    $0.left.equalTo(body)
                }else{
                    $0.right.equalTo(body)
                }
                if i / 2 == 1{
                     $0.top.equalTo(body).offset(150)
                }else{
                     $0.top.equalTo(body)
                }
            }
            
        }
    }
}