//
//  ContentView.swift
//  SwiftUIButtons
//
//  Created by Zeljko Marinkovic on 21/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Button 1", action: { print("Button 1 action") })
            
            Button(action: {print("Button 2 action")} ) {
                Text("Button 2")
            }
            
            Button(action: { print("Button 3 action") }) {
                Label("Button 3", systemImage: "plus")
            }
            .background(.teal)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
            Button(action: { print("Button 3 action") }) {
                Image(systemName: "plus")
            }
            .background(.teal)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
            Button(role: .destructive, action: { print("Button 4 action") }) {
                Label("Button 4", systemImage: "minus")
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
