//
//  ContentView.swift
//  space-finder
//
//  Created by Turma01-4 on 29/07/24.
//

import SwiftUI

struct Bloco: Identifiable {
    let id = UUID()
    let name: String
    let color: String
    let numVagas: Int
}

struct Blocks: View {
  //  @ObservedObject var viewModel = ViewModel()
    
    let arrayBlocos = [
        Bloco(name: "Bloco A", color: "green-card", numVagas: 0),
        Bloco(name: "Bloco B", color: "red-card", numVagas: 10),
        Bloco(name: "Bloco C", color: "green-card", numVagas: 2),
        Bloco(name: "Bloco D", color: "yellow-card", numVagas: 6)
    ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("bg-blue")
                    .ignoresSafeArea()
                
                VStack{
                    // circulo e endereco
                    HStack(spacing: 10){
                        Circle()
                            .frame(width: 110)
                            .foregroundStyle(Color.grayCard)
                        
                        VStack(alignment: .leading){
                            Text("Rua manoel tavares")
                            Text("bairro: palmeiras")
                            Text("numero: 123")
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding()
                    
                    // retangulo listra
                    Rectangle()
                        .fill(Color("gray-card"))
                        .frame(height: 2)
                    NavigationLink(destination: MapView()){
                        VStack{
                            //blocos cards
                            Spacer()
                            ForEach(0..<4) { i in
                                Rectangle()
                                    .cornerRadius(15)
                                    .frame(height: 80)
                                    .frame(maxWidth: 600)
                                    .padding()
                                    .foregroundStyle(Color.grayCard)
                                    .overlay(
                                        VStack{
                                            Text("\(arrayBlocos[i].name)").font(.title2).bold()
                                            Text("\(arrayBlocos[i].numVagas)/10 vagas").font(.title2)
                                        }.padding(.leading, 30)
                                    )
                                    .overlay(
                                        Rectangle()
                                            .fill(Color(arrayBlocos[i].color))
                                            .cornerRadius(15)
                                            .padding(.leading)
                                            .frame(width: 100, height: 80),
                                        alignment: .leading
                                        
                                    )
                                    .overlay(Image(systemName: "car").padding(.leading, 27),
                                             alignment: .leading)
                                    .font(.system(size: 40)).foregroundColor(.black)
                                
                            }
                            Spacer()
                        }}.navigationBarBackButtonHidden()
                }
                
            }
            
        }
    }
}

#Preview {
    Blocks()
}


/*  VStack {
      ForEach(viewModel.API, id: \._id) { i in
          ForEach(i.bloco_A, id: \.id) { j in
              Text("Vaga \(j.id) Disponivel: \(j.disponivel)")
          }
          
      }
  }.onAppear() {
      viewModel.getData()
      
  }
  .padding() */
