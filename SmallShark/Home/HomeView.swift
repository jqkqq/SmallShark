//
//  ContentView.swift
//  Imessage

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
            ImessageView(imageData: viewModel.dataImages)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


