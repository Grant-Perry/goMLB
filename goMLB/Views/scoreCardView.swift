//   scoreCardView.swift
//   goMLB
//
//   Created by: Grant Perry on 5/10/24 at 1:24 PM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

struct scoreCardView: View {
   var vm: GameViewModel
   var event: GameEvent
   var titleSize: CGFloat
   var tooDark: String
   var scoreSize: Int

   @Binding var refreshGame: Bool
   @Binding var timeRemaining: Int

   // Computed properties to handle dynamic content
   private var home: String? { vm.filteredEvents.first?.home }
   private var homeScore: String { vm.filteredEvents.first?.homeScore ?? "0" }
   private var homeRecord: String? { vm.filteredEvents.first?.homeRecord}
   private var homeColor: String? { vm.filteredEvents.first?.homeColor }
   private var homeWin: Bool { (Int(visitScore) ?? 0) > (Int(homeScore) ?? 0) }

   private var visitors: String? { vm.filteredEvents.first?.visitors }
   private var visitScore: String { vm.filteredEvents.first?.visitScore ?? "0" }
   private var visitorRecord: String? { vm.filteredEvents.first?.visitorRecord}
   private var visitColor: String? { vm.filteredEvents.first?.visitorAltColor }
   private var visitWin: Bool { (Int(visitScore) ?? 0) <= (Int(homeScore) ?? 0) }

   private var inningTxt: String? { vm.filteredEvents.first?.inningTxt }
   private var startTime: String? { vm.filteredEvents.first?.startTime }
   private var atBat: String? { vm.filteredEvents.first?.atBat }
   private var atBatPic: String? { vm.filteredEvents.first?.atBatPic }
   private var winColor: Color { .green }
   private var liveAction: Bool { true }

   var body: some View {
	  VStack {
		 // MARK: Header
		 headerView(refreshGame: $refreshGame,
					timeRemaining: $timeRemaining,
					titleSize: titleSize,
					tooDark: tooDark,
					event: event,
					vm: vm)
		 .padding(.top, 60)

		 // MARK: Scores card
		 HStack(spacing: 20) { // Proper spacing between elements
							   // MARK: Visitor's Side
			VStack(alignment: .leading, spacing: 2) {
			   Text("\(visitors ?? "")")
				  .font(.title3.weight(.bold))
				  .minimumScaleFactor(0.5)
				  .lineLimit(1)
				  .foregroundColor(getColorForUI(hex: visitColor ?? "#000000", thresholdHex: tooDark))
//				  .scaleEffect(1.25) // Increase size by 25%
			   Text("\(visitorRecord ?? "")")
				  .font(.caption)
				  .foregroundColor(.white)
				  .alignmentGuide(.trailing) { d in d[.trailing] } // Align with the trailing edge of the visitor's name
			}

			// MARK: Visitor Score
			Text("\(visitScore)")
			   .font(.system(size: CGFloat(scoreSize)))

//			   .padding(.leading)

			// MARK: Home Score
			Text("\(homeScore)")
			   .font(.system(size: CGFloat(scoreSize)))
			   .padding(.trailing)
			   .foregroundColor(homeWin && Int(homeScore) ?? 0 > 0 ? winColor : .white)

			// MARK: HOME (right) side
			VStack(alignment: .trailing, spacing: 2) {
			   Text("\(home ?? "")")
				  .font(.title3.weight(.bold))
				  .minimumScaleFactor(0.5)
				  .lineLimit(1)
				  .foregroundColor(getColorForUI(hex: homeColor ?? "#000000", thresholdHex: tooDark))
				  .scaleEffect(1.25) // Increase size by 25%
			   Text("\(homeRecord ?? "")")
				  .font(.caption)
				  .foregroundColor(.white)
				  .alignmentGuide(.leading) { d in d[.leading] } // Align with the leading edge of the home's name
			}
		 }
		 .frame(width: UIScreen.main.bounds.width, height: 110)
		 .overlay(
			HStack {
			   TeamIconView(teamColor: visitColor ?? "C4CED3",
							teamIcon: event.visitorLogo,
							fullIcon: true)
			   .scaledToFit()
			   .foregroundColor(.white)
			   .opacity(0.2)
			   Spacer()
			   TeamIconView(teamColor: homeColor ?? "C4CED3",
							teamIcon: event.homeLogo,
							fullIcon: true)
			   .scaledToFit()
			   .foregroundColor(.white)
			   .opacity(0.2)
			}
			   .padding(.horizontal, 20) // Ensure icons are within visible bounds
		 )
	  }  // full card
	  .frame(width: UIScreen.main.bounds.width  * 0.9, height: .infinity)
   }
}

//#Preview {
//    scoreCardView()
//}
