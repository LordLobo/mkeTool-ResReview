//
//  ContentView.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/4/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var editMode: EditMode = .inactive
    
    @ObservedObject private var dataSource = CoreDataSource<Resturant>()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
