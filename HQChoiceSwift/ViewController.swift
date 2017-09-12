//
//  ViewController.swift
//  HQChoiceSwift
//
//  Created by HaiQuan on 2017/9/12.
//  Copyright © 2017年 HaiQuan. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {


    private let disposeBag = DisposeBag()

    
    fileprivate let arrowView = HQArrow()


    fileprivate lazy var selectedLabel = {()->UILabel in

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "selectedLabel"
        label.textColor = .yellow
        return label

    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.addSubview(arrowView)
        arrowView.snp.makeConstraints { (make) in

            make.top.equalTo(100)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }

        arrowView.selectedArrow?.subscribe(onNext: {


            print($0.direction)
        }).addDisposableTo(disposeBag)



        view.addSubview(selectedLabel)
        selectedLabel.snp.makeConstraints { (make) in
            make.center.equalTo(view.snp.center)
        }

        arrowView.selectedArrow?.map{ "\($0.direction)"}.bind(to: selectedLabel.rx.text).addDisposableTo(disposeBag)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

