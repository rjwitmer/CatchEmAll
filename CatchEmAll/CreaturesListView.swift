//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Bob Witmer on 2023-08-04.
//

import SwiftUI

struct CreaturesListView: View {
    @StateObject var creaturesVM = CreaturesViewModel()
    var body: some View {
        NavigationStack {
            List(creaturesVM.creaturesArray, id: \.self) { creature in
                Text(creature.name)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
        .task {
            await creaturesVM.getData()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreaturesListView()
    }
}
