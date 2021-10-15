//
//  AuthorDetailView.swift
//  HoneyRabbit

import SwiftUI

struct AuthorDetailView: View {
    
    var viewModel = AuthorDetailViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack {
                AuthorTextView(title: "作者：  \(viewModel.name)")
                AuthorTextView(title: "email：  \(viewModel.email)")
                AuthorTextView(title: viewModel.note)
                Spacer()
                Image("1")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                
            }
        }.background(Color.init(red: 187/255, green: 1, blue: 1))
        
    }
}

struct AuthorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorDetailView()
    }
}

struct AuthorTextView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 20))
            .padding()
            .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
            .lineLimit(100)
    }
}
