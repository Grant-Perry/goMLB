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
	var titleSize: CGFloat
	var tooDark: String
	var event: gameEvent
	var scoreSize: Int
	//   var visitorRecord: Int

	@Binding var refreshGame: Bool
	@Binding var timeRemaining: Int

	// Computed properties to handle dynamic content
	private var home: String? { vm.filteredEvents.first?.home }
	private var homeScore: String { vm.filteredEvents.first?.homeScore ?? "0" }
	private var homeRecord: String? { vm.filteredEvents.first?.homeRecord}
	private var visitorRecord: String? { vm.filteredEvents.first?.visitorRecord}
	private var homeColor: String? { vm.filteredEvents.first?.homeColor }
	private var visitors: String? { vm.filteredEvents.first?.visitors }
	private var visitScore: String { vm.filteredEvents.first?.visitScore ?? "0" }
	private var visitColor: String? { vm.filteredEvents.first?.visitorAltColor }
	private var homeWin: Bool { (Int(visitScore) ?? 0) > (Int(homeScore) ?? 0) }
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

			//		 }
			// MARK: Scores card
			HStack(spacing: 0) {
				// MARK: Visitor's Side
				HStack { // Visitor Side
					VStack(alignment: .leading, spacing: 0) {
						VStack {
							Text("\(visitors ?? "")")
								.font(.title3)
								.minimumScaleFactor(0.5)
								.lineLimit(1)
								.frame(width: 110, alignment: .leading)
								.foregroundColor(getColorForUI(hex: visitColor ?? "#000000", thresholdHex: tooDark))
							//							  .border(.red)

							Text("\(visitorRecord ?? "")")
								.font(.caption)
								.foregroundColor(.gray)
							Spacer()
						}
						VStack {
							HStack { // Aligns content to the trailing edge (right)
								Spacer()
//								TeamIconView(teamColor: visitColor ?? "C4CED3", teamIcon: event.visitorLogo)
//									.clipShape(Circle())
							}
							.frame(width: 90, alignment: .leading)

						}
					}

					// MARK: Visitor Score
					Text("\(visitScore)")
						.font(.system(size: CGFloat(scoreSize)))
						.padding(.trailing)
						.foregroundColor(visitWin && Int(visitScore) ?? 0 > 0 ? winColor : Color(hex: visitColor!))
				} // end Visitor Side
				.frame(maxWidth: .infinity, alignment: .trailing)
//								  .border(.green)
				.overlay(
					TeamIconView(teamColor: visitColor ?? "C4CED3",
									 teamIcon: event.visitorLogo,
									 fullIcon: true)
//														.clipShape(Circle())
//						.resizable()
//						.border(.red)
						.scaledToFit()
						.foregroundColor(.white)
						.opacity(0.2), // 20% opacity
//						.frame(width: 190)), // Adjust the size as needed
					alignment: .center)


				// MARK: HOME (right) side
				HStack { // Home side
					Text("\(homeScore)")
						.font(.system(size: CGFloat(scoreSize)))
						.padding(.leading)
						.foregroundColor(homeWin && Int(homeScore) ?? 0 > 0 ? winColor : Color(hex: homeColor!))


					VStack(alignment: .leading) {
						VStack {
							Text("\(home ?? "")")
								.font(.title3)
								.foregroundColor(getColorForUI(hex: homeColor ?? "#000000", thresholdHex: tooDark))
								.minimumScaleFactor(0.5)
								.lineLimit(1)

							Text("\(vm.filteredEvents.first?.homeRecord ?? "")")
								.font(.caption)
								.foregroundColor(.gray)
						}

						VStack {
							HStack { // Aligns content to the trailing edge (right)
										//							  Spacer()
//								TeamIconView(teamColor: homeColor ?? "C4CED3", teamIcon: event.homeLogo, fullIcon: true)
//									.clipShape(Circle())
							}
							.frame(width: 90, alignment: .trailing)
							//						   .border(.green)
						}
					}

				} // end Home side
				.frame(maxWidth: .infinity, alignment: .leading)
				.overlay(
					TeamIconView(teamColor: homeColor ?? "C4CED3",
									 teamIcon: event.homeLogo,
									 fullIcon: true)
						.scaledToFit()
						.foregroundColor(.white)
						.opacity(0.2), // 20% opacity
					alignment: .center)
				//				  .border(.red)

			} // End both sides
			.frame(width: UIScreen.main.bounds.width, height: 110)
						   .border(.blue)


		}  // full card
		.frame(width: UIScreen.main.bounds.width  * 0.9, height: .infinity)
	}
}

//#Preview {
//    scoreCardView()
//}
