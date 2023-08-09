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
            ZStack {
                List(0..<creaturesVM.creaturesArray.count, id: \.self) { index in
                    
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creaturesVM.creaturesArray[index])
                        } label: {
                            Text("\(index + 1).  \(creaturesVM.creaturesArray[index].name.capitalized)")
                                .font(.title2)
                        }
                    }
                    .onAppear{
                        if let lastCreature = creaturesVM.creaturesArray.last {
                            if creaturesVM.creaturesArray[index].name == lastCreature.name && creaturesVM.urlString.hasPrefix("http") {
                                Task {
                                    await creaturesVM.getData()
                                }
                            }
                        }
                    }
                    
                }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await creaturesVM.loadAll()
                            }
                        }
                    }
                    ToolbarItem(placement: .status) {
                        Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count)")
                    }
                }
                
                if creaturesVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }

            }
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
