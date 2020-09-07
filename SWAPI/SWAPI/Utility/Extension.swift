//
//  Extension.swift
//  SWAPI
//
//  Created by Malav Soni on 07/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation
import SwiftUI

extension ObservableObject {
    var isInternetAvailable:Bool {
        APIClient.isInternetAvailable
    }
    var internetUnavailableMessage:String {
        SWError.internetNotAvailable.localizedDescription
    }
}

extension View {
    func showAlert(isPresented:Binding<Bool>, message:String) -> some View {
        return self.alert(isPresented: isPresented) {
            Alert(title: Text("SWAPI APP"), message: Text(message), dismissButton: .default(Text("Okey")))
        }
    }
}
