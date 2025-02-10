import SwiftUI

struct PraguePage: View {
    let experiences: [Experience] = [
        Experience(number: 1, name: "Prague Castle Tour", category: "Landmark", rating: 10),
        Experience(number: 2, name: "Harrods", category: "Shopping", rating: 10),
        Experience(number: 3, name: "Westminster Abbey", category: "Landmark | Church", rating:9.6),
        Experience(number: 4, name: "Borough Market", category: "Shopping", rating: 6.0),
        Experience(number: 5, name: "The Tate Modern", category: "Art | Museum", rating: 5.2)
    ]

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image("praguebg")
                    .resizable()
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 190)
                
                VStack(spacing: 4) {
                    Text("12 Experiences")
                        .font(.system(size:17))
                        .bold()
                        .foregroundColor(.white)
                    Text("Prague")
                        .font(.system(size:55))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .multilineTextAlignment(.center)
                .padding()
                .offset(y:-50)

                HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 25, height: 20)
                        .padding(.leading, 25)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                }
                .offset(x:-6, y: -150)
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
        
        // Bottom Navigation Bar
        VStack {
            Divider()
            HStack {
                Spacer()
                VStack {
                    Image("navhome")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navfeed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navlog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navsaved")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navprofile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
            }
            .padding(.vertical, 2)
            .offset(y:6)
        }
    }
}

#Preview {
    PraguePage()
}
