//
//  DrawRepresentableView.swift
//  Imessage

import UIKit
import SwiftUI

enum DrawViewState {
    case back
    case clear
    case normal
}

struct DrawRepresentableView: UIViewRepresentable {
    
    var imageName: String
    @Binding var state: DrawViewState
    @Binding var brushWidth: CGFloat
    @Binding var color: UIColor
    var onCommit: (DrawView) -> Void
    
    func makeUIView(context: Context) -> DrawView {
        let view = DrawView()
        view.mainImageView.image = UIImage(named: imageName)
        guard let saveImage = view.mainImageView.image else {
            return view
        }
        view.saveImages.append(saveImage)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: DrawView, context: Context) {
        if state != uiView.state {
            switch state {
            case .back:
                uiView.previousImage()
            case .clear:
                uiView.clearImage()
                uiView.mainImageView.image = UIImage(named: imageName)
                guard let saveImage = uiView.mainImageView.image else {
                    return
                }
                uiView.saveImages.append(saveImage)
            case .normal:
                break
            }
            uiView.state = .normal
        } else {
            uiView.color = color
            uiView.brushWidth = brushWidth

        }
        print("state: \(state)")
        print("view state: \(uiView.state)")
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, onCommit: onCommit)
    }
    
    typealias UIViewType = DrawView
    
    
    class Coordinator: NSObject, DrawViewDelegate {
        
        var parent: DrawRepresentableView
        var onCommit: (DrawView) -> Void
        
        init(parent: DrawRepresentableView, onCommit: @escaping(DrawView) -> Void) {
            self.parent = parent
            self.onCommit = onCommit
        }
        
        func drawViewDidChange(_ drawView: DrawView) {
            onCommit(drawView)
        }

    }
}

