import SwiftUI

struct Experience: Identifiable {
    let id = UUID()
    let number: Int
    let name: String
    let category: String
    let rating: Double
}

struct LondonPage: View {
    let experiences: [Experience] = [
        Experience(number: 1, name: "Big Ben Tour", category: "Landmark", rating: 10),
        Experience(number: 2, name: "Harrods", category: "Shopping", rating: 9.6),
        Experience(number: 3, name: "Westminster Abbey", category: "Landmark | Church", rating:9.6),
        Experience(number: 4, name: "Borough Market", category: "Shopping", rating: 4.8),
        Experience(number: 5, name: "The Tate Modern", category: "Art | Museum", rating: 4.3)
    ]

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image("londonbg")
                    .resizable()
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 190)
                
                VStack(spacing: 4) {
                    Text("9 Experiences")
                        .font(.system(size:17))
                        .bold()
                        .foregroundColor(.white)
                    Text("London")
                        .font(.system(size:55))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .multilineTextAlignment(.center)
                .padding()
                .offset(y:-50)

                HStack {
                    Button(action: {
                        NotificationCenter.default.post(name: .dismissLondonPage, object: nil)
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 20)
                    }
                    .padding(.leading, 25)
                    
                    Spacer()
                    
                    Button(action: {
                        print("Share button tapped")
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 25)
                }
                .offset(y: -150)
            }
            
            List(experiences) { experience in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(experience.number). \(experience.name)")
                            .offset(y:-5)
                            .font(.system(size: 16))
                            .bold()
                        Text(experience.category)
                            .offset(y: 3)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(
                        experience.rating == 10.0
                            ? "10"
                            : String(format: "%.1f", experience.rating)
                    )
                    .font(.system(size:17))
                    .bold()
                        .padding(7)
                        .background(
                                experience.rating >= 9.0
                                ? Color(red: 4/255, green: 57/255, blue: 11/255)
                                : Color(red: 255/255, green: 248/255, blue: 228/255)
                            )
                        .clipShape(Circle())
                        .frame(width: 50, height: 44)
                        .foregroundColor(experience.rating >= 9.0
                                         ? Color(red: 255/255, green: 248/255, blue: 228/255)
                                         : Color(red: 4/255, green: 57/255, blue: 11/255))
                }
                .padding(.vertical, 17)
            }
            .listStyle(PlainListStyle())
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

#Preview {
    LondonPage()
}
