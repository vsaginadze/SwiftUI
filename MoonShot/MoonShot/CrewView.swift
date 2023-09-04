//
//  CrewView.swift
//  MoonShot
//
//  Created by Vakhtang Saginadze on 28.08.2023.
//

import SwiftUI

struct CrewView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    @State private var currentPage = 0
    
    var body: some View {
        HStack {
            TabView(selection: $currentPage) {
                ForEach(0..<crew.count, id: \.self) { idx in
                    let crewMember: CrewMember = crew[idx]
                    
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut, missions: missions, astronauts: astronauts)
                    } label: {
                        SlideView(crewMember: crewMember)
                            .tag(idx)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            Button {
                withAnimation {
                    currentPage = (currentPage + 1) % crew.count
                }
            } label: {
                Image(systemName: "arrowshape.forward.fill")
                    .padding()
                    .background(.lightBackground)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
    
    struct SlideView: View {
        let crewMember: CrewMember
        
        var body: some View {
            HStack {
                Image(crewMember.astronaut.id)
                        .resizable()
                        .frame(width: 104, height: 72)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .strokeBorder(.white, lineWidth: 1)
                        )
                
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .foregroundColor(.white)
                        .font(.headline)

                    Text(crewMember.role)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut], missions: [Mission]) {
        self.mission = mission
        self.astronauts = astronauts
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError()
            }
        }
        self.missions = missions
    }
}

struct CrewView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        CrewView(mission: missions[0], astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
