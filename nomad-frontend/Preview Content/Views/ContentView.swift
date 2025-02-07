//
//  ContentView.swift
//  nomad-frontend
//
//  Created by Chloe Park on 2/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        Text("Hello, world!")
    }
}

#Preview {
    ContentView()
}
