//
//  EditViewModel.swift
//  Imessage

import SwiftUI
import Combine



class EditViewModel: ObservableObject {
    
    //MARK: - Input
    var changeColor = PassthroughSubject<UIColor, Never>()
    
    //MARK: - Output
    @Published var imageName: String
    @Published var colors: [SelectColor] = []
    
    //MARK: - properties
    private var cancellabels: [AnyCancellable] = []
    var mainImageView: UIImageView? = nil

    //MARK: - init
    init(imageName: String) {
        self.imageName = imageName
        
        SelectColors.createData()
            .assign(to: \.colors, on: self)
            .store(in: &cancellabels)
        
        changeColor
            .map({ changeColor -> [SelectColor] in
                var changeColors = self.colors
                changeColors.indices.forEach {
                    if changeColors[$0].color == changeColor {
                        changeColors[$0].select = true
                    } else {
                        changeColors[$0].select = false
                    }
                }
                return changeColors
            })
            .assign(to: \.colors, on: self)
            .store(in: &cancellabels)
    }
    
}
