//
//  DetailView.swift
//  CatchEmAll
//
//  Created by Bob Witmer on 2023-08-07.
//

import SwiftUI

struct DetailView: View {
    @StateObject var creatureDetailVM = CreatureDetailViewModel()
    
    var creature: Creature
    
    var body: some View {
        VStack (alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            HStack {
                AsyncImage(url: URL(string: creatureDetailVM.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .background(.white)
                        .frame(maxHeight: 96)
                        .cornerRadius(16)
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                        .padding(.trailing)
                } placeholder: {
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.green)
                        .progressViewStyle(.circular)

                }
                
                VStack (alignment: .leading) {
                    HStack (alignment: .top) {
                        Text("Height:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                        Text(String(format: "%.1f", creatureDetailVM.height))
                            .font(.title)
                            .bold()
                    }
                    HStack (alignment: .top) {
                        Text("Weight:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                        Text(String(format: "%.1f", creatureDetailVM.weight))
                            .font(.title)
                            .bold()
                    }
                }
            }
            
            Spacer()
            
        }
        .padding()
        .task {
            creatureDetailVM.urlString = creature.url
            await creatureDetailVM.getData()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(creature: Creature(name: "Place Holder", url: "https://pokeapi.co/api/v2/pokemon/1/"))
    }
}
