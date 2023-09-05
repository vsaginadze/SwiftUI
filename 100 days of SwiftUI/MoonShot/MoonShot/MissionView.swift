//
//  MissionView.swift
//  MoonShot
//
//  Created by Vakhtang Saginadze on 08.08.2023.
//

import SwiftUI

struct RectangleView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.vertical)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.title2.bold())
                    
                    VStack(alignment: .leading) {
                        RectangleView()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
        
                        Text(mission.description)
                        
                        RectangleView()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission, astronauts: astronauts, missions: missions)
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut], missions: [Mission]) {
        self.mission = mission
        self.astronauts = astronauts
        self.missions = missions
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
