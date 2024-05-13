//   liveGameScoreView.swift
//   goMLB
//
//   Created by: Grant Perry on 5/11/24 at 10:09 AM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

struct LiveGameScoreView: View {

   var vm: GameViewModel //= GameViewModel()
   var titleSize: CGFloat
   var tooDark: String
   var event: GameEvent
   var scoreSize: Int
   private var gp: GameEvent? { vm.filteredEvents.first }


   // Computed properties to handle dynamic content
   private var home: String? { gp?.home }
   private var homeScore: String { gp?.homeScore ?? "0" }
   private var homeRecord: String? { gp?.homeRecord}
   private var visitorRecord: String? { gp?.visitorRecord}
   private var visitors: String? { gp?.visitors }
   private var visitScore: String { gp?.visitScore ?? "0" }
   private var inningTxt: String? { gp?.inningTxt }
   private var visitLogo: String? { gp?.visitorLogo  }
   private var homeLogo: String? { gp?.homeLogo  }

   var basesInfo: String = "0-0, 1 out"
   var pitcherInfo: String = "PHI: Nola (15 pitches, 3.36 era)"
   var batterInfo: String = "NYM: Nimmo (0-0, .298 ba)"

   @State private var textAlignment: HorizontalAlignment = .center
   @State private var leadTrail: Edge.Set = .leading

   var body: some View {
	  VStack(alignment: textAlignment) {
		 // MARK: Team scores
		 HStack {
			HStack {
			   goLoadLogoAsync(teamLogoURL: visitLogo ?? "", leadTrail: .leading)
			   teamView(teamName: visitors ?? "", record: visitorRecord ?? "", score: Int(visitScore) ?? 0)
			}
			Spacer()
			HStack {
			   BasesView(onFirst: true,
						 onSecond: false,
						 onThird: true,
						 strikes: 1,
						 balls: 3,
						 outs: 2,
						 inningTxt: "Last pitch: STRIKE",
						 thisSubStrike:	0,
						 atBat: "Big Gp.",
						 atBatPic: "https://a.espncdn.com/i/headshots/mlb/players/full/31027.png",
						 showPic: false)
			}
			.frame(maxWidth: 50, maxHeight: 50, alignment: .top)
			.padding(.bottom, 20)

			Spacer()
			HStack {
			   teamView(teamName: home ?? "", record: homeRecord ?? "", score: Int(homeScore) ?? 0)
			   goLoadLogoAsync(teamLogoURL: homeLogo ?? "", leadTrail: .trailing)
			}
		 }
		 .padding([.top, .horizontal])

		 // MARK: last play and pitcher info
		 VStack {
			Text("\(inningTxt ?? "") | \(basesInfo)")
			   .bold()
			   .font(.subheadline)
			   .foregroundColor(Color(hex: "FFFFFF"))
			   .padding(.top, 8)  // Added top padding here
			   .padding(.horizontal)

			Text(pitcherInfo)
			   .font(.caption)
			   .foregroundColor(Color(hex: "FFFFFF"))
			   .padding(.horizontal)
			Text(batterInfo)
			   .font(.caption)
			   .foregroundColor(Color(hex: "FFFFFF"))
			   .frame(maxWidth: .infinity, alignment: .center)
			   .padding([.bottom, .horizontal])

		 } // end of bottom section
		 .background(.gray.gradient)

	  } // end of full card

	  .background(Color(hex: "#444444"))
	  .cornerRadius(20)
	  .shadow(radius: 5)
	  .padding(3)
	  .environment(\.horizontalSizeClass, textAlignment == .leading ? .compact : .regular)

	  .onAppear(perform: vm.loadData)

   }
}

struct teamView: View {
   var teamName: String
   var record: String
   var score: Int

   var body: some View {
	  VStack(alignment: .leading, spacing: 2) {
		 Text(teamName)
			.font(.headline)
			.foregroundColor(Color(hex: "FFFFFF"))
		 Text(record)
			.font(.caption)
			.foregroundColor(Color(hex: "bbbbbb"))
		 Text("\(score)")
			.font(.largeTitle)
			.bold()
			.foregroundColor(Color(hex: "FFFFFF"))
	  }

	  .preferredColorScheme(.dark)
   }


}

struct goLoadLogoAsync: View {
   var teamLogoURL: String
   var leadTrail: Edge.Set

   var body: some View {
	  AsyncImage(url: URL(string: teamLogoURL)) { image in
		 image.resizable()
	  } placeholder: {
		 Color.gray
	  }
	  .frame(width: 50, height: 50)
	  .padding(leadTrail, 10)
   }
}

#Preview {
   teamView(teamName: "Yankees", record: "23-9", score: 9)
}
