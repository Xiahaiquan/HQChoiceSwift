//
//  HQArrow.swift
//  SmartIron
//
//  Created by HaiQuan on 2017/9/11.
//  Copyright © 2017年 HaiQuan. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class HQArrow: UIView {



   fileprivate lazy var monthLabel = {()->UILabel in

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "centLabel"
        label.textColor = .red
        return label
        
    }()




    var selectedArrow: Observable<ArrowView>?

    private let disposeBag = DisposeBag()


    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)

        self.backgroundColor = .clear
        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configUI() {


        addSubview(monthLabel)
        monthLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }



        let leftArrow = ArrowView( .left)
        addSubview(leftArrow)
        leftArrow.snp.makeConstraints { (make) in

            make.width.height.equalTo(28)
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(10)
        }





        let rightArrow = ArrowView(.right)
        addSubview(rightArrow)

        rightArrow.snp.makeConstraints { (make) in

            make.width.height.equalTo(28)
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.trailing).offset(-10)
        }


        selectedArrow = Observable.from(
            [leftArrow, rightArrow].map { arrow in arrow.rx.controlEvent(.touchUpInside).map { arrow } }
            ).merge()





    }

}
class ArrowView: UIControl {

    var direction: Direction = .left

    //箭头边距
    fileprivate let  margin: CGFloat = 4

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        UIColor.blue.set()

        let path = UIBezierPath()
        path.lineWidth = 2
        path.lineCapStyle = .butt
        path.lineJoinStyle = .round

        switch direction {

        case .left:
            path.move(to: CGPoint.init(x: self.width - margin, y: margin))
            path.addLine(to: CGPoint.init(x: margin, y: self.middleY))
            path.addLine(to: CGPoint.init(x:self.width - margin, y: self.height - margin))
        case .right:
            path .move(to: CGPoint.init(x: margin, y: margin))
            path.addLine(to: CGPoint.init(x: self.width - margin, y: self.middleY))
            path.addLine(to: CGPoint.init(x: margin, y: self.height - margin))

        case .cent: break

        }

        path.stroke()

    }
    
    init( _ dir:Direction) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .clear
        direction = dir
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}

enum Direction {
    
    case cent
    case left
    case right
}

