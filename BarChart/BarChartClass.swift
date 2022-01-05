//
//  BarChartView.swift
//  TestBarChart
//
//  Created by Kiara on 11.12.21.
//

import UIKit

class BarChartView: UIView {
    var maxValue: Double = 100.0
    let values: [Double] = []

    private func clearView(){
        self.subviews.forEach({$0.removeFromSuperview()})
    }


    public func drawChart(_ values: [Double]){
        clearView()
        
        self.backgroundColor = .clear
        if(values.count == 0){
            let label = UILabel()
            label.frame = self.frame
            label.text = "No Data"
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            return self.addSubview(label)
        }
        drawAxes()
        
        let width = (self.frame.width - 20.0) / Double(values.count)
        var num = 20.0
        let spacer = Double(( 20 * width ) / 100)
        let barwidth = width - spacer
        
        //create bars
        for i in 0..<values.count  {
            let text = UILabel()
            let view = UIView()
    
            let hei = ((Double(values[i] * 100 ) / maxValue) * self.frame.height) / 100 - 5
            let textheight = (Double((1 * 100 ) / maxValue) * self.frame.height) / 100 //labels with height of 1
        
            view.backgroundColor = .systemTeal
            
            let hi = self.frame.height
            view.frame = CGRect(x: num, y: (self.frame.maxY - self.frame.origin.y), width: barwidth, height: (hi-(hi + hei)) )
            
            view.layer.cornerRadius = 5.0
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            text.frame = CGRect(x: num, y: (self.frame.maxY - self.frame.origin.y), width: barwidth, height: -textheight)
            text.text = "\(values[i])"
            text.textAlignment = .center
            text.adjustsFontSizeToFitWidth = true
            if(i % 2 == 0){ view.backgroundColor = .systemBlue}

         //Bar description
            let labelheight = 1.5 * Double(textheight)
           let barlabel = UILabel()
            barlabel.frame = CGRect(x: num, y: (self.frame.maxY - self.frame.origin.y), width: barwidth, height: labelheight)
            barlabel.text = "\(i)."
            barlabel.adjustsFontSizeToFitWidth = true
            barlabel.textAlignment = .center
            
            //draw everything
            self.addSubview(view)
            self.addSubview(text)
            self.addSubview(barlabel)
            
            num += barwidth + spacer
        }
    }
    
    private func drawAxes(){
        //Y-Axis
        let yAxis = UIView()
        yAxis.frame = CGRect(x: 17.0, y: 0.0, width: 1.0, height: self.frame.height)
        yAxis.backgroundColor = .systemGray3
        self.addSubview(yAxis)
        
        //1/4, 1/2, 3/4 1 lines
        let zeroLineValue = (self.frame.maxY - self.frame.origin.y)
        //1 line
        drawAxe(0.0, "\(maxValue)")
        //1/2 line
        drawAxe((0.5 * zeroLineValue), "\(0.5 * maxValue)")
        //1/4 line
        drawAxe((0.25 * zeroLineValue), "\(0.75 * maxValue)")
        //3/4 line
        drawAxe((0.75 * zeroLineValue), "\(0.25 * maxValue)")
    }

    func drawAxe(_ height: Double, _ title: String){
            let line4 = UIView()
        line4.frame = CGRect(x: 15.0, y: CGFloat(height + 5.0), width: self.frame.width - 20, height: 1.0)
        line4.backgroundColor = .systemGray3
        self.addSubview(line4)
        let label4 = UILabel()
        label4.frame = CGRect(x: 0.0, y: CGFloat(height) , width: 15.0, height: 15.0)
        label4.text = title
        label4.adjustsFontSizeToFitWidth = true
        label4.textColor = .systemGray3
        self.addSubview(label4)
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
