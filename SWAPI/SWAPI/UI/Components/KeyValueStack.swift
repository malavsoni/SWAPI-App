//
//  KeyValueStack.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct KeyValueHStack:View {
    let key:String
    let value:String
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
        }
    }
}

struct KeyValueVStack:View {
    let key:String
    let value:String
    var body: some View {
        VStack(alignment:.leading) {
            Text(key)
                .font(.body)
            Text(value)
                .font(.footnote)
        }
    }
}
