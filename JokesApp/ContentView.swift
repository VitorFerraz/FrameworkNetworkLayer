//
//  ContentView.swift
//  JokesApp
//
//  Created by Vitor Ferraz Varela on 02/08/21.
//

import SwiftUI
import Network
import FrameworkNetworkLayer

class JokeViewModel: ObservableObject {
    @Published var message: String = "🤠"
    @Published var isFetching = false
    
    let network: NetworkLayer = URLSessionNetworkLayer()
    
    func fetchJoke() async {
        isFetching = true
        defer { isFetching = false }
        do {
            let joke: Joke = try await network.request(service: JokesService.randomJoke)
            message = joke.value
        } catch {
            message = error.localizedDescription
        }
    }
}
struct ContentView: View {
    @StateObject var viewModel: JokeViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(viewModel.message)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(30)
            }
            .background(.blue)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .gray, radius: 20, x: 0, y: 20)
            VStack {
                Spacer()
                Button {
                    Task.init {
                        await viewModel.fetchJoke()
                    }
                } label: {
                    Text("Buscar uma piada")
                        .padding()
                        .foregroundColor(.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .opacity(viewModel.isFetching ? 0 : 1)
                        .overlay {
                            if viewModel.isFetching { ProgressView() }
                        }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: JokeViewModel())
    }
}
