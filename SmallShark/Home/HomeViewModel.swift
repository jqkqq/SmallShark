//
//  HomeViewModel.swift
//  Imessage
import Foundation
import Combine
import UIKit

class HomeViewModel: ObservableObject {
    
    //MARK: - Input
    
    
    //MARK: - Output
    @Published var dataImages: [String] = []
    
    //MARK: - porperteis
    private var cancellabels: [AnyCancellable] = []
    
    init() {
        DataImage.setData()
            .assign(to: \.dataImages, on: self)
            .store(in: &cancellabels)
    }

}
