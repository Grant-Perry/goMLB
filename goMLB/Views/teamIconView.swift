//   teamIconView.swift
//   goMLB
//
//   Created by: Gp. on 4/25/24 at 10:30 AM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

struct TeamIconView: View {
	let teamColor: String // = "C4CED3"
	let teamIcon: String // = "https://a.espncdn.com/i/teamlogos/mlb/500/scoreboard/nyy.png"
	let frameSize = 120.0
	let fullIcon: Bool

	var body: some View {
		ZStack {
			if fullIcon {
				Circle()
					.stroke(Color.white, lineWidth: 1) // 1px white stroke
					.background(Circle().fill(Color(hex: teamColor)))
					.frame(width: frameSize + 20, height: frameSize + 20) // Circle size
			}

			AsyncImage(url: URL(string: teamIcon)) { phase in
				// Use the 'phase' parameter to determine the state of the download and provide UI accordingly
				if let image = phase.image {
					image.resizable() // Allow image resizing
						.aspectRatio(contentMode: .fit) // Maintain aspect ratio
						.frame(width: frameSize) // Icon size within the circle
						.shadow(color: fullIcon ? .clear : .clear, radius: 2, x: 0, y: 2) // Shadow for the icon
//						.shadow(color: fullIcon ? .gray : .clear, radius: 2, x: 0, y: 2) // Shadow for the icon
				} else if phase.error != nil {
					Color.red // Indicates an error
				} else {
					ProgressView() // Shows a loading indicator until the download finishes
				}
			}
			.frame(width: frameSize - 5) // This frame will apply to the AsyncImage view itself, including the placeholder and error state
			.foregroundColor(.white)
		}
		.preferredColorScheme(.dark)
	}
}

//#Preview {
//	TeamIconView()
//}
