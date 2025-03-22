//
//  ViewController.swift
//  hw5
//
//  Created by Rory on 2025/3/20.
//

import UIKit



class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let center = view.center
        
        //畫頭
        let head = DoraemonPart(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
                                fillColor: .systemBlue,
                                shapeType: "circle",
                                size: 250)
        head.center = center
        view.addSubview(head)
        
        // 畫臉
        let face = DoraemonPart(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
                                fillColor: .white,
                                shapeType: "ellipse_w",
                                size: 200)
        face.center = CGPoint(x: center.x , y: center.y + 40)
        view.addSubview(face)
        
        // 畫左右眼睛
        addSymmetricParts(center: center, offsetX: 30, offsetY: -20,
                          frame: CGRect(x: 0, y: 0, width: 40, height: 50),
                          fillColor: .white,
                          shapeType: "ellipse_l",
                          size: 40)
        
        // 畫左右瞳孔
        addSymmetricParts(center: center, offsetX: 30, offsetY: -20,
                          frame: CGRect(x: 0, y: 0, width: 10, height: 10),
                          fillColor: .black,
                          shapeType: "circle",
                          size: 10)
        
        // 畫鼻子
        let nose = DoraemonPart(frame: CGRect(x: 0, y: 0, width: 30, height: 30),
                                fillColor: .red,
                                shapeType: "circle",
                                size: 30)
        nose.center = CGPoint(x: center.x, y: center.y + 30)
        view.addSubview(nose)
        
        // 畫微笑的嘴巴
        let mouth = DoraemonPart(frame: CGRect(x: 0, y: 0, width: 100, height: 60),
                                 fillColor: .clear,
                                 strokeColor: .black,
                                 shapeType: "curve",
                                 size: 100)
        mouth.center = CGPoint(x: center.x, y: center.y + 90)
        view.addSubview(mouth)
        
        
        // 畫左右鬍鬚，三條在左邊，三條在右邊
        for i in 0..<3 { // 用一個迴圈畫三次
            let yOffset = 40 + CGFloat(i * 10)
            addSymmetricParts(center: center, offsetX: 60, offsetY: yOffset,
                              frame: CGRect(x: 0, y: 0, width: 50, height: 2),
                              fillColor: .black,
                              shapeType: "line",
                              size: 50)
        }
        
    }
    
    // 這是一個幫我畫左右一樣東西的小幫手
    private func addSymmetricParts(center: CGPoint, offsetX: CGFloat, offsetY: CGFloat, frame: CGRect, fillColor: UIColor, shapeType: String, size: CGFloat) {
        // 畫左邊
        let leftPart = DoraemonPart(frame: frame, fillColor: fillColor, shapeType: shapeType, size: size)
        leftPart.center = CGPoint(x: center.x - offsetX, y: center.y + offsetY)
        view.addSubview(leftPart)
        
        // 畫右邊
        let rightPart = DoraemonPart(frame: frame, fillColor: fillColor, shapeType: shapeType, size: size)
        rightPart.center = CGPoint(x: center.x + offsetX, y: center.y + offsetY)
        view.addSubview(rightPart)
    }
}

class DoraemonPart: UIView {
    var fillColor: UIColor
    var strokeColor: UIColor
    var lineWidth: CGFloat
    var shapeType: String
    var size: CGFloat
    
    init(frame: CGRect, fillColor: UIColor, strokeColor: UIColor = .black, lineWidth: CGFloat = 2.0, shapeType: String, size: CGFloat) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.shapeType = shapeType
        self.size = size
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawPart() {
        let path = UIBezierPath()
        
        if shapeType == "circle" {
            path.append(UIBezierPath(ovalIn: CGRect(x: (frame.width - size) / 2, y: (frame.height - size) / 2, width: size, height: size)))
        } else if shapeType == "ellipse_w" {
            path.append(UIBezierPath(ovalIn: CGRect(x: (frame.width - size) / 2, y: (frame.height - size * 0.8) / 2, width: size, height: size * 0.8)))
        } else if shapeType == "ellipse_l"  {
            path.append(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: frame.width, height: frame.height)))
        } else if shapeType == "line" {
            path.move(to: CGPoint(x: 0, y: frame.height / 2))
            path.addLine(to: CGPoint(x: frame.width, y: frame.height / 2))
        } else if shapeType == "curve" {
            path.move(to: CGPoint(x: frame.width * 0.2, y: frame.height * 0.2))
            path.addQuadCurve(to: CGPoint(x: frame.width * 0.8, y: frame.height * 0.2), controlPoint: CGPoint(x: frame.width / 2, y: frame.height * 0.8))
        }
        
        fillColor.setFill()
        strokeColor.setStroke()
        path.lineWidth = lineWidth
        path.fill()
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        drawPart()
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateInitialViewController()!
}
