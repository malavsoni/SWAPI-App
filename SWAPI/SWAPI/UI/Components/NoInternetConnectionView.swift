//
//  NoInternetConnectionView.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct NoInternetConnectionView: View {
    var onRetry:() -> Void
    var body: some View {
        VStack {
            Text("Internet connection appears to be offline.")
                .font(.headline)
            Button(action: self.onRetry, label: {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .font(.system(size: 25, weight: .regular))
                    .foregroundColor(.black)
            })
        }
        .padding()
        .frame(maxWidth :.infinity)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10.0)
        .padding()
    }
}

struct NoInternetConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetConnectionView(onRetry: {
            
        })
    }
}
