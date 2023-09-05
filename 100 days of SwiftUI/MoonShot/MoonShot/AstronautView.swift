//
//  AstronautView.swift
//  MoonShot
//
//  Created by Vakhtang Saginadze on 27.08.2023.
//

import SwiftUI

struct AstronautView: View {
    
    @State private var isClicked = false
    let astronaut: Astronaut
    var missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.8)
                        .cornerRadius(20)
                        .padding(.top)
                    
                    RectangleView()
                    
                    Text(astronaut.name)
                        .font(.title.bold())
                        .padding(.bottom, 5)
    
                    Text(astronaut.description)
                    
                    RectangleView()
                    
                    Text("Missions")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    ForEach(missions) { mission in
                        VStack(alignment: .leading) {
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts, missions: missions)
                                } label: {
                                    HStack {
                                        Image(mission.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 60)
                                        
                                        Text(mission.displayName)
                                            .foregroundColor(.white)
                                            .font(.title2.bold())
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(astronaut: Astronaut, missions: [Mission], astronauts: [String: Astronaut]) {
        self.astronaut = astronaut
        self.missions = missions
        self.astronauts = astronauts
        
        var matches = [Mission]()
        for mission in missions {
            if mission.crew.first(where: {$0.name == self.astronaut.id}) != nil {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!, missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
