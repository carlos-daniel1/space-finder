
import SwiftUI
import MapKit

struct ContentView: View {
    @State var searchText: String = ""
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -7.250608776707808, longitude: -35.869656855856604),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    )
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.bgBlue
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "car.front.waves.up")
                                .resizable()
                                .frame(width: 50, height: 55)
                                .padding(.leading, 25)
                                .padding(.top, 25)
                            Spacer()
                            Image("logo")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .padding(.leading, 10)
                                .padding(.bottom, -30)
                        }
                        .padding(.top, -45)
                        
                        Rectangle()
                            .frame(width: 395, height: 0.5)
                            .padding(.top, -25)
                            .foregroundColor(.white)
                            .opacity(0.5)
                        
                        SearchBar(text: $searchText)
                            .padding(.top, 10)
                            .padding(.horizontal, 25)
                    }
                    
                    Map(position: $position) {
                        Annotation("bloco A (TEATRO)", coordinate: CLLocationCoordinate2D(latitude: -7.250450580058449, longitude: -35.87123487936871)) {
                            NavigationLink(destination: Blocks()){
                                
                                    //tODOS DIRECIONAM PRO BLOCO A
                                
                                    Image(systemName: "mappin.and.ellipse.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 29))
                                
                            }}
                        
                        Annotation("bloco B (ACCENTURE)", coordinate: CLLocationCoordinate2D(latitude: -7.250608776707808, longitude: -35.869656855856604)) {
                            NavigationLink(destination: Blocks()){
                                
                                    Image(systemName: "mappin.and.ellipse.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 29))
                                
                            }}
                        
                        Annotation("bloco C (ARENA)", coordinate: CLLocationCoordinate2D(latitude: -7.251512, longitude: -35.870758)) {
                            NavigationLink(destination: Blocks()){
                                
                                    Image(systemName: "mappin.and.ellipse.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 29))
                                
                            }}
                    }
                    .border(Color(white: 20, opacity: 0.6))
                    .cornerRadius(15)
                    .padding(.top, 30)
                    
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading, 10)
            TextField("Pesquisar Endereço", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
        }
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
