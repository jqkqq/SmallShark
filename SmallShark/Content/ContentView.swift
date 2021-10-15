//
//  ContentView.swift
//  HoneyRabbit

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HomeView().tabItem {
                Image("icons8-image-32")
            }
            
            AuthorDetailView().tabItem {
                Image("icons8-new-property-32")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
