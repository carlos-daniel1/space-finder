import SwiftUI


struct Vaga: Identifiable {
    let id = UUID()
    let name: String
    let color: String
    let disponivel: Bool
}


let arrayVagas = [
    Vaga(name: "VagaA", color: "green-card", disponivel: true),
    Vaga(name: "Bloco B", color: "red-card", disponivel: false),
    Vaga(name: "Bloco C", color: "green-card", disponivel: false)
]

struct MapView: View {
    
    @ObservedObject var viewModel = ViewModel()
    var body: some View {

        NavigationStack {
            ZStack {
                Color("bg-blue")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        
                        NavigationLink(destination: Blocks()){
                            Image(systemName: "chevron.backward.2")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 30)
                                .padding()
                        }
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                        
                        
                    }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    Spacer()
                    
                    Rectangle().foregroundColor(.white).opacity(0.9).cornerRadius(5).padding().overlay{
                        HStack{
                            ForEach(0..<3){i in
                                Rectangle().frame(maxWidth: 100).frame(maxHeight: 200).foregroundColor(.gray)
                                    .overlay(
                                        VStack {
                                            ForEach(viewModel.API, id: \._id) { j in
                                                Text(j.bloco_A[0].id_vaga)
                                                Text(j.bloco_A[0].situacao)
                                                
                                            }
                                          }.onAppear() {
                                              viewModel.getData()
                                              
                                          })
                            }
                        }
                        
                        }
                    }
                    .padding(.bottom)

                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }



#Preview {
    MapView()
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
