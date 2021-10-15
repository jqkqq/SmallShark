//
//  DrawView.swift
//  LearnToWriteABC

import UIKit

class DrawView: UIView {
    
    //MARK: - UI
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var tempImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //MARK: - 繪圖的屬性
    var state: DrawViewState = .normal
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    private var lastPoint = CGPoint.zero
    private var swiped = false
    var saveImages: [UIImage] = []
    weak var delegate: DrawViewDelegate?
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(tempImageView)
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        tempImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tempImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tempImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tempImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }

    //MARK: - override touch 系列
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        swiped = false
        lastPoint = touch.location(in: tempImageView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        swiped = true
        let currentPoint = touch.location(in: tempImageView)
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped{
            drawLine(from: lastPoint, to: lastPoint)
        }
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: tempImageView.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: tempImageView.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tempImageView.image = nil
        guard let saveImage = mainImageView.image else {
            return
        }
        saveImages.append(saveImage)
        delegate?.drawViewDidChange(self)
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: tempImageView.bounds)
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        context.strokePath()
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    func clearImage() {
        mainImageView.image = nil
        saveImages.removeAll()
    }
    
    func previousImage() {
        if saveImages.count > 1 {
            saveImages.removeLast()
            guard let saveImage = saveImages.last else {
                clearImage()
                return
            }
            mainImageView.image = saveImage
        }
    }

}

protocol DrawViewDelegate: AnyObject {
    func drawViewDidChange(_ drawView: DrawView)
}
