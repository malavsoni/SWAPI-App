//
//  DestinationView.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct DestinationView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(
            Text("Hello")
        )
    }
}
