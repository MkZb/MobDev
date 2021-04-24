//
//  DrawView.swift
//  MobDev
//
//  Created by Mykola Zubets on 24.04.2021.
//

import UIKit

class DrawView: UIView {

    override func draw(_ rect: CGRect){
        let cords = UIBezierPath()
        //Coordinates
        cords.move(to: CGPoint(x: 0, y: rect.height/2))
        cords.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
        cords.addLine(to: CGPoint(x: rect.width - 10, y: rect.height/2 + 5))
        cords.move(to: CGPoint(x: rect.width, y: rect.height/2))
        cords.addLine(to: CGPoint(x: rect.width - 10, y: rect.height/2 - 5))
        cords.move(to: CGPoint(x: rect.width/2, y: rect.height))
        cords.addLine(to: CGPoint(x: rect.width/2, y: 0))
        cords.addLine(to: CGPoint(x: rect.width/2 - 5, y: 10))
        cords.move(to: CGPoint(x: rect.width/2, y: 0))
        cords.addLine(to: CGPoint(x: rect.width/2 + 5, y: 10))
        
        let y_one = rect.height/54
        let x_one = y_one
        cords.move(to: CGPoint(x: rect.width/2 + x_one, y: rect.height/2 - 5))
        cords.addLine(to: CGPoint(x: rect.width/2 + x_one, y: rect.height/2 + 5))
        
        cords.move(to: CGPoint(x: rect.width/2 - 5, y: rect.height/2 - y_one))
        cords.addLine(to: CGPoint(x: rect.width/2 + 5, y: rect.height/2 - y_one))
        
        cords.stroke()
        
        //Graphic
        let graphic = UIBezierPath()
        UIColor.blue.set()
        graphic.move(to: CGPoint(x: rect.width/2 - 3 * x_one, y: rect.height))
        for i in -30...30 {
            let x = Double(i)/10
            let y = pow(x, 3)
            graphic.addLine(to: CGPoint(x: rect.width/2 + CGFloat(x) * x_one, y: rect.height/2 - CGFloat(y) * y_one))
        }
        graphic.stroke()
    }
}
