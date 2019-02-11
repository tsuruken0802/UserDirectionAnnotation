//
//  ViewController.swift
//  UserDirectionAnnotation
//
//  Created by 鶴本賢太朗 on 2019/02/11.
//  Copyright © 2019 Kentarou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     var circleview: UserMapDirectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.circleview = UserMapDirectionView()
        self.circleview.frame = CGRect(x: 200, y: 100, width: 30, height: 30)
        self.view.addSubview(self.circleview)
    }
}

class UserMapDirectionView: UIView {
    private var whiteCircleLayer: CircleLayer!
    private var blueCircleLayer: CircleLayer!
    private var triangleLayer: TriangleLayer!
    private let blueColor: UIColor = UIColor(red: 55/255, green: 132/255, blue: 240/255, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initLayers()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initLayers()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setLayerFrame()
        self.setLayerPath()
    }
}

extension UserMapDirectionView {
    private func initLayers() {
        self.whiteCircleLayer = CircleLayer()
        self.blueCircleLayer = CircleLayer()
        self.triangleLayer = TriangleLayer()
        self.layer.addSublayer(self.whiteCircleLayer)
        self.layer.addSublayer(self.blueCircleLayer)
        self.layer.addSublayer(self.triangleLayer)
        self.layer.masksToBounds = false
    }
    private func setLayerFrame() {
        do {
            self.whiteCircleLayer.frame = self.bounds
        }
        do {
            let width: CGFloat = self.frame.width * 0.75
            let height: CGFloat = self.frame.height * 0.75
            let x: CGFloat = (self.frame.width - width) / 2
            let y : CGFloat = (self.frame.height - height) / 2
            self.blueCircleLayer.frame = CGRect(x: x, y: y, width: width, height: height)
        }
        do {
            let height: CGFloat = self.whiteCircleLayer.frame.height * 0.3
            let width: CGFloat = height * 1.5
            let x: CGFloat = self.frame.width / 2 - width / 2
            let y: CGFloat = (self.blueCircleLayer.frame.minY - self.whiteCircleLayer.frame.minY) / 1.1 - height
            self.triangleLayer.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    private func setLayerPath() {
        self.whiteCircleLayer.fillColor = UIColor.white.cgColor
        self.blueCircleLayer.fillColor = self.blueColor.cgColor
        self.triangleLayer.fillColor = self.blueColor.cgColor
    }
}

class CircleView: UIView {
    
    internal var strokeColor: UIColor = .white
    internal var fillColor: UIColor = .white
    internal var lineWidth: CGFloat = 0
    
    override class var layerClass: AnyClass {
        return CircleLayer.self
    }
    private var circleLayer: CircleLayer {
        return self.layer as! CircleLayer
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setLayerPath()
    }
}

extension CircleView {
    private func setLayerPath() {
        self.circleLayer.strokeColor = self.strokeColor.cgColor
        self.circleLayer.fillColor = self.fillColor.cgColor
        self.circleLayer.lineWidth = self.lineWidth
    }
}

class CircleLayer: CAShapeLayer {
    override func layoutSublayers() {
        super.layoutSublayers()
        self.setLayerPath()
    }
}

extension CircleLayer {
    private func setLayerPath() {
        let path: UIBezierPath = UIBezierPath(ovalIn: self.bounds)
        self.path = path.cgPath
    }
}

class TriangleLayer: CAShapeLayer {
    override func layoutSublayers() {
        super.layoutSublayers()
        self.setLayerPath()
    }
}

extension TriangleLayer {
    private func setLayerPath() {
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: self.bounds.width / 2, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addCurve(to: CGPoint(x: 0, y: self.bounds.height), controlPoint1: CGPoint(x: self.bounds.width * (3/4), y: self.bounds.height - (self.bounds.height / 6)), controlPoint2: CGPoint(x: self.bounds.width * (1/4), y: self.bounds.height - (self.bounds.height / 6)))
        path.close()
        self.path = path.cgPath
    }
}
