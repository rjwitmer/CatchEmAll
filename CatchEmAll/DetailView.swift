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
                creatureImage
               
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

extension DetailView {
    var creatureImage: some View {
        AsyncImage(url: URL(string: creatureDetailVM.imageURL)) { phase in
            if let image = phase.image {    // We have a valid image
                image
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .frame(width: 96, height: 96)
                    .cornerRadius(16)
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    }
                    .padding(.trailing)
            } else if phase.error != nil {  // We have an error
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .frame(width: 96, height: 96)
                    .cornerRadius(16)
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    }
                    .padding(.trailing)
            } else {    // Use a placeholder
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 96, height: 96)
                    .padding(.trailing)
            }
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(creature: Creature(name: "Place Holder", url: "https://pokeapi.co/api/v2/pokemon/1/"))
    }
}
