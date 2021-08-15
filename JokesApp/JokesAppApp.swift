//
//  JokesAppApp.swift
//  JokesApp
//
//  Created by Vitor Ferraz Varela on 02/08/21.
//

import SwiftUI

@main
struct JokesAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: JokeViewModel())
        }
    }
}
