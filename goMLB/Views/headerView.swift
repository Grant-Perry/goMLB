//   headerView.swift
//   goMLB
//
//   Created by: Gp. on 5/10/24 at 6:37 PM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

struct headerView: View {

	@Binding var refreshGame: Bool
	@Binding var timeRemaining: Int

	var titleSize: CGFloat
	var tooDark: String
	var event: gameEvent
	var vm: GameViewModel

	private var home: String? { vm.filteredEvents.first?.home }
	private var homeColor: String? { vm.filteredEvents.first?.homeColor }
	private var visitors: String? { vm.filteredEvents.first?.visitors }
	private var visitColor: String? { vm.filteredEvents.first?.visitorAltColor }
	private var inningTxt: String? { vm.filteredEvents.first?.inningTxt }
	private var startTime: String? { vm.filteredEvents.first?.startTime }

	var body: some View {
		VStack(spacing: 0) {

			HStack(alignment: .center) {
				VStack(spacing: -4) {  // Remove spacing between VStack elements

					HStack(spacing: -4) {
						Spacer()
						HStack {
							Text("\(visitors ?? "")")
								.font(.system(size: titleSize))
								.foregroundColor(getColorForUI(hex: visitColor ?? "#000000", thresholdHex: tooDark))
								.frame(width: 150, alignment: .trailing)
								.lineLimit(1)
								.minimumScaleFactor(0.5)
						}
						HStack {
							Text("vs")
								.font(.footnote)
							//									  .multilineTextAlignment(.center)
								.padding(.vertical, 2)
								.frame(width: 40)
						}

						HStack {
							Text("\(home ?? "")")
								.font(.system(size: titleSize))
								.foregroundColor(getColorForUI(hex: homeColor ?? "#000000", thresholdHex: tooDark))
								.frame(width: 150, alignment: .leading)
								.lineLimit(1)
								.minimumScaleFactor(0.5)

						}
						Spacer()
					}

					if (inningTxt?.contains("Scheduled") ?? false ) {
						Text("\nStarting: \(startTime ?? "")")
							.font(.system(size: 14))
							.foregroundColor(.white)
					}
					else {
						Text("\(inningTxt ?? "")")
							.font(.system(size: 14))
							.foregroundColor(.white)
							.padding(.top, 5)
					}

					// MARK: Outs view

					if let lowerInningTxt = inningTxt {
						if lowerInningTxt.contains("Top") || lowerInningTxt.contains("Bot")  {
							outsView(outs: event.outs ?? 0 )
								.frame(width: UIScreen.main.bounds.width, height: 20)
								.padding(.top, 6)
								.font(.system(size: 11))
						}
					}

					Button(action: {
						refreshGame.toggle() // Toggle the state of refreshGame on click
					}) {
						Text((refreshGame ? "Updating" : "Not Updating") + "\n")
							.foregroundColor(refreshGame ? .green : .red) // Change color based on refreshGame
							.font(.caption) // Set the font size
							.frame(width: 200, height: 22, alignment: .trailing) // Frame for the text, right aligned
							.padding(.trailing) // Padding inside the button to the right

						if refreshGame {
							timerRemaingView(timeRemaining: $timeRemaining)
								.font(.system(size: 20))
								.frame(width: 200, height: 11, alignment: .trailing) // Frame for the text, right aligned
								.padding(.top, -17)
						}
					}
					.frame(maxWidth: .infinity, alignment: .trailing) // Ensure the button itself is right-aligned
					.padding(.trailing, 20) // Padding from the right edge of the container
					.cornerRadius(10) // Rounded corners for the button
				}
				.multilineTextAlignment(.center)
				.padding()
				.lineSpacing(0)
			}
			.frame(width: UIScreen.main.bounds.width, height: 200)
			.minimumScaleFactor(0.25)
			.scaledToFit()
		}

		.frame(width: UIScreen.main.bounds.width, height: 120, alignment: .trailing)
		.cornerRadius(10)

	}
}
