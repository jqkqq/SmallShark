//
//  ImageView.swift
//  Imessage


import SwiftUI

struct ImessageView: View {
    
    var imageData: [String]
    @State private var showDetailView = false
    @State private var imageName = "" {
        didSet {
            print(self.imageName)
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
            let columns = [GridItem(), GridItem(), GridItem()]
            LazyVGrid(columns: columns, content: {
                ForEach(imageData.indices) { index in
                    
                    NavigationLink(
                        destination:
                            EditView(viewModel: EditViewModel(imageName: imageData[index]), state: .normal),
                        label: {
                            Image(imageData[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3, alignment: .center)
                        })
                
                }
            })
        })
        .background(Color.init(red: 187/255, green: 1, blue: 1))
        .navigationBarTitle("小鯊鯊貼圖", displayMode: .inline)
        
    }
}

