//
//  ViewController.swift
//  FunWave
//
//  Created by WHC on 17/9/4.
//  Copyright © 2017年 WHC. All rights reserved.
//

import UIKit
import WHC_Layout

class ViewController: UIViewController {

    @IBOutlet private weak var stackView: WHC_StackView!
    @IBOutlet private weak var scroolView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /// 配置stakView
        stackView.whc_Orientation = .vertical
        stackView.whc_VSpace = 10
        stackView.whc_Edge = UIEdgeInsetsMake(0, 10, 10, 10)
        stackView.whc_SubViewHeight = 100
        
        scroolView.whc_AutoSize(left: 0, top: 64, right: 0, bottom: 10)
        stackView.whc_Left(0)
        .whc_RightEqual(self.view)
        .whc_Top(0)
        .whc_HeightAuto()
        .whc_Bottom(0)
        
        for _ in 0 ..< 10 {
            let item = FunWaveView()
            stackView.addSubview(item)
        }
        stackView.whc_StartLayout()
        
        stackView.subviews.enumerated().forEach { (index, fun) in
            if let wave = fun as? FunWaveView {
                wave.waveSpeed = CGFloat(7 + index * 2);
                wave.waveColor1 = UIColor(displayP3Red: randomNumber(0 ..< 255) / 255.0,
                                          green: randomNumber(0 ..< 255) / 255.0,
                                          blue: randomNumber(0 ..< 255) / 255.0, alpha: 0.5)
                wave.waveColor1 = UIColor(displayP3Red: randomNumber(0 ..< 255) / 255.0,
                                          green: randomNumber(0 ..< 255) / 255.0,
                                          blue: randomNumber(0 ..< 255) / 255.0, alpha: 0.5)
                wave.start()
            }
        }
    }
    
    func randomNumber(_ range: Range<Int>) -> CGFloat {
        let distance = range.upperBound - range.lowerBound
        let rnd = arc4random_uniform(UInt32(distance))
        return CGFloat(range.lowerBound + Int(rnd))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

