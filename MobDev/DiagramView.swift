//
//  DiagramView.swift
//  MobDev
//
//  Created by Mykola Zubets on 24.04.2021.
//

import UIKit

class DiagramView: UIView {

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let R = min(rect.width, rect.height) / 2 * 0.9
        
        let segment1 = UIBezierPath()
        UIColor.yellow.set()
        segment1.move(to: center)
        segment1.addLine(to: CGPoint(x: center.x + R, y: center.y))
        segment1.addArc(withCenter: center, radius: R, startAngle: 0, endAngle: 2 * CGFloat.pi * 0.15, clockwise: true)
        segment1.addLine(to: center)
        UIColor.yellow.setFill()
        segment1.fill()
        segment1.stroke()
        
        let segment2 = UIBezierPath()
        UIColor.brown.set()
        segment2.move(to: center)
        segment2.addLine(to: CGPoint(x: center.x + R * cos(2 * CGFloat.pi * 0.15), y: center.y + R * sin(2 * CGFloat.pi * 0.15)))
        segment2.addArc(withCenter: center, radius: R, startAngle: 2 * CGFloat.pi * 0.15, endAngle: 2 * CGFloat.pi * 0.4, clockwise: true)
        segment2.addLine(to: center)
        UIColor.brown.setFill()
        segment2.fill()
        segment2.stroke()
        
        let segment3 = UIBezierPath()
        UIColor.gray.set()
        segment3.move(to: center)
        segment3.addLine(to: CGPoint(x: center.x + R * cos(2 * CGFloat.pi * 0.4), y: center.y + R * sin(2 * CGFloat.pi * 0.4)))
        segment3.addArc(withCenter: center, radius: R, startAngle: 2 * CGFloat.pi * 0.4, endAngle: 2 * CGFloat.pi * 0.85, clockwise: true)
        segment3.addLine(to: CGPoint(x: center.x, y: center.y))
        UIColor.gray.setFill()
        segment3.fill()
        segment3.stroke()
        
        let segment4 = UIBezierPath()
        UIColor.red.set()
        segment4.move(to: center)
        segment4.addLine(to: CGPoint(x: center.x + R * cos(2 * CGFloat.pi * 0.85), y: center.y + R * sin(2 * CGFloat.pi * 0.85)))
        segment4.addArc(withCenter: center, radius: R, startAngle: 2 * CGFloat.pi * 0.85, endAngle: 2 * CGFloat.pi * 0.95, clockwise: true)
        segment4.addLine(to: CGPoint(x: center.x, y: center.y))
        UIColor.red.setFill()
        segment4.fill()
        segment4.stroke()
        
        let segment5 = UIBezierPath()
        UIColor.purple.set()
        segment5.move(to: center)
        segment5.addLine(to: CGPoint(x: center.x + R * cos(2 * CGFloat.pi * 0.95), y: center.y + R * sin(2 * CGFloat.pi * 0.95)))
        segment5.addArc(withCenter: center, radius: R, startAngle: 2 * CGFloat.pi * 0.95, endAngle: 2 * CGFloat.pi, clockwise: true)
        segment5.addLine(to: CGPoint(x: center.x, y: center.y))
        UIColor.purple.setFill()
        segment5.fill()
        segment5.stroke()
    }
}
