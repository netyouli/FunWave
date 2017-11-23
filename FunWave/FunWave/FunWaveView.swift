//
//  FunWaveView.swift
//  bgy
//
//  Created by WHC on 17/9/1.
//  Copyright © 2017年 WHC. All rights reserved.
//
//  Github <https://github.com/netyouli/FunWave>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
/// 波浪公式： y = h * sin(ax + b) + c

import UIKit

/// 波浪动画组件

public class FunWaveView: UIView {

    private lazy var waveLayer1 = CAShapeLayer()
    private lazy var waveLayer2 = CAShapeLayer()
    private var timer: CADisplayLink!
    
    private lazy var waveWidthRange: CGFloat = 0
    private lazy var waveHeightRange: CGFloat = 0
    private lazy var isIncrement = true
    private lazy var rate: CGFloat = 0.1
    
    /// 波浪高度
    public var waveHeight: CGFloat = 0 {
        didSet {
            self.layoutIfNeeded()
            rate = waveHeight / bounds.height
        }
    }
    /// 波浪速度
    public lazy var waveSpeed: CGFloat = 7
    /// 波浪颜色
    public lazy var waveColor1: UIColor = UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 0.5)
    public lazy var waveColor2: UIColor = UIColor(red: 220.0 / 255.0, green: 220.0 / 255.0, blue: 220.0 / 255.0, alpha: 0.5)
    
    deinit {
        stop()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        initWaveLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        initWaveLayer()
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initWaveLayer() {
        rate = 0.5
        self.layer.addSublayer(waveLayer1)
        self.layer.addSublayer(waveLayer2)
    }
    
    private func setWaveLayer(_ waveLayer: CAShapeLayer, waveColor: UIColor) {
        waveLayer.frame = self.bounds
        waveLayer.backgroundColor = UIColor.clear.cgColor
        waveLayer.lineWidth = 1
        waveLayer.strokeColor = UIColor.clear.cgColor
        waveLayer.fillColor = waveColor.cgColor
        waveLayer.strokeStart = 0
        waveLayer.strokeEnd = 1
    }
    
    /// 开始波浪
    public func start() {
        self.layoutIfNeeded()
        setWaveLayer(waveLayer1, waveColor: waveColor1)
        setWaveLayer(waveLayer2, waveColor: waveColor2)
        
        timer = CADisplayLink(target: self, selector: #selector(handleTimer))
        timer.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    /// 停止波浪
    public func stop() {
        timer?.remove(from: RunLoop.current, forMode: .commonModes)
        timer?.invalidate()
    }
    
    @objc private func handleTimer() {
        /* change wave height
        if isIncrement {
            if rate >= 0.65 {
                isIncrement = false
            }else {
                waveWidthRange += 7
                rate += 0.0005
            }
        }else {
            if rate <= 0.35 {
                isIncrement = true
            }else {
                rate -= 0.0005
                waveWidthRange -= 7
            }
        }*/
        if isIncrement {
            if waveWidthRange >= CGFloat.greatestFiniteMagnitude {
                isIncrement = false
            }else {
                waveWidthRange += waveSpeed
            }
        }else {
            if waveWidthRange <= 0 {
                isIncrement = true
            }else {
                waveWidthRange -= waveSpeed
            }
        }
        
        waveHeightRange = bounds.height * rate * 0.3
        let wavePath1 = UIBezierPath()
        let wavePath2 = UIBezierPath()
        var y1 = (1 - rate) * bounds.height
        var y2 = y1
        wavePath1.move(to: CGPoint(x: 0, y: y1))
        wavePath2.move(to: CGPoint(x: 0, y: y2))
        let a = 3 / bounds.width * CGFloat(M_PI)
        for x in 0 ... Int(bounds.width) {
            let b1 = 2 * waveWidthRange / bounds.width * CGFloat(M_PI)
            let b2 = (waveWidthRange / bounds.width + 1) * CGFloat(M_PI)
            let c = (1 - rate) * bounds.height
            y1 = waveHeightRange * CGFloat(sin(Double(a * CGFloat(x) + b1))) + c
            y2 = waveHeightRange * CGFloat(sin(Double(a * CGFloat(x) + b2))) + c
            wavePath1.addLine(to: CGPoint(x: CGFloat(x), y: y1))
            wavePath2.addLine(to: CGPoint(x: CGFloat(x), y: y2))
        }
        wavePath1.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        wavePath1.addLine(to: CGPoint(x: 0, y: bounds.height))
        waveLayer1.path = wavePath1.cgPath
        wavePath2.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        wavePath2.addLine(to: CGPoint(x: 0, y: bounds.height))
        waveLayer2.path = wavePath2.cgPath
    }
    
    private func randomNumber(_ range: Range<Int>) -> CGFloat {
        let distance = range.upperBound - range.lowerBound
        let rnd = arc4random_uniform(UInt32(distance))
        return CGFloat(range.lowerBound + Int(rnd))
    }
}
