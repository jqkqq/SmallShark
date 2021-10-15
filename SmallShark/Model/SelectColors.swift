//
//  SelectColors.swift
//  Imessage


import Foundation
import Combine

class SelectColors {
    static func createData() -> AnyPublisher<[SelectColor], Never> {
        return Just([SelectColor(color: .white, select: false),
                     SelectColor(color: .black, select: true),
                     SelectColor(color: .blue, select: false),
                     SelectColor(color: .red, select: false),
                     SelectColor(color: .green, select: false),
                     SelectColor(color: .systemPink, select: false),
                     SelectColor(color: .yellow, select: false),
                     SelectColor(color: .orange, select: false),
                     SelectColor(color: .purple, select: false),
                     SelectColor(color: .gray, select: false)])
            .eraseToAnyPublisher()
    }
}
