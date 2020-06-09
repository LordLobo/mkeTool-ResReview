//
//  AvgStarView.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/9/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct AvgStar: View {
    var rating: Double
    
    init(_ rating: Double) {
        self.rating = rating
    }
    
    var body: some View {
        ZStack {
            Image(systemName: "star")
                .resizable()
                .frame(width: 75, height: 75)
            Text("\(String(format: "%.1f", self.rating))")
                .font(Font.system(size: 13))
                
        }
    }
}
