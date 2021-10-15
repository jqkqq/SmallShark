//
//  DataImage.swift
//  Imessage
import Foundation
import Combine

class DataImage {
    static func setData() -> AnyPublisher<[String], Never> {
        let data = createData(30)
        return Just(data)
            .eraseToAnyPublisher()
    }
    
    static private func createData(_ number: Int) -> [String] {
        var data: [String] = []
        for i in 1...number {
            data.append("\(i)")
        }
        return data
    }
}
