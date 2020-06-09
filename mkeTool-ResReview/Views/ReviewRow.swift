//
//  ReviewRow.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/9/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct ReviewRow: View {
    var review: Review
    
    init (_ review: Review) {
        self.review = review
    }
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("\(self.review.date!, formatter: Self.dateFormat)")
            
            HStack {
                AvgStar(Double(self.review.rating))
                
                Spacer()
                
                Text("\(self.review.review!)")
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(5)
        .background(Color("RtBg"))
        .cornerRadius(6)
    }
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreData.stack.context
        let resturant = Resturant.createResturant(name: "Test Resturant", type: ResturantType.createResturantType(resturantType: "TestCuisine"))
        let review = Review.createReviewFor(resturant, text: "this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review this is my review ", rating: 2, date: Date.init())
        
        return ReviewRow(review)
                .environment(\.managedObjectContext, context)
                .previewLayout(.sizeThatFits)
                .padding(10)
    }
}
