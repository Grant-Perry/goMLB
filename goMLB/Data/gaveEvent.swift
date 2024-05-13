//   gaveEvent.swift
//   goMLB
//
//   Created by: Grant Perry on 4/30/24 at 4:37 PM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

struct GameEvent: Hashable {

   var ID: UUID = UUID()
   var title: String        // Full title of the event.
   var shortTitle: String   // Shortened title of the event.
   var home: String         // Home team name.
   var visitors: String     // Visiting team name.
   var homeRecord: String  //  Home team's season record
   var visitorRecord: String  // Visitor's season record
   var inning: Int          // Current inning number.
   var homeScore: String    // Home team's current score.
   var visitScore: String   // Visitor team's current score.
   var homeColor: String 	// home colors
   var homeAltColor: String
   var visitorColor: String 	// visitors colors
   var visitorAltColor: String
   var on1: Bool            // Runner on first base.
   var on2: Bool            // Runner on second base.
   var on3: Bool            // Runner on third base.
   var lastPlay: String?    // Description of the last play.
   var balls: Int?          // Current ball count.
   var strikes: Int?        // Current strike count.
   var outs: Int?           // Current out count.
   var homeLogo: String
   var visitorLogo: String
   var inningTxt: String
   var thisSubStrike: Int
   var thisCalledStrike2: Bool
   var startDate: String
   var startTime: String
   var atBat: String
   var atBatPic: String
   var atBatSummary: String

   init(ID: UUID = UUID(),
		title: String,
		shortTitle: String,
		home: String,
		visitors: String,
		homeRecord: String,
		visitorRecord: String,
		inning: Int,
		homeScore: String,
		visitScore: String,
		homeColor: String,
		homeAltColor: String,
		visitorColor: String,
		visitorAltColor: String,
		on1: Bool,
		on2: Bool,
		on3: Bool,
		lastPlay: String? = nil,
		balls: Int? = nil,
		strikes: Int? = nil,
		outs: Int? = nil,
		homeLogo: String,
		visitorLogo: String,
		inningTxt: String,
		thisSubStrike: Int,
		thisCalledStrike2: Bool,
		startDate: String,
		startTime: String,
		atBat: String,
		atBatPic: String,
		atBatSummary: String) {

	  self.ID = ID
	  self.title = title
	  self.shortTitle = shortTitle
	  self.home = home
	  self.visitors = visitors
	  self.homeRecord = homeRecord
	  self.visitorRecord = visitorRecord
	  self.inning = inning
	  self.homeScore = homeScore
	  self.visitScore = visitScore
	  self.homeColor = homeColor
	  self.homeAltColor = homeAltColor
	  self.visitorColor = visitorColor
	  self.visitorAltColor = visitorAltColor
	  self.on1 = on1
	  self.on2 = on2
	  self.on3 = on3
	  self.lastPlay = lastPlay
	  self.balls = balls
	  self.strikes = strikes
	  self.outs = outs
	  self.homeLogo = homeLogo
	  self.visitorLogo = visitorLogo
	  self.inningTxt = inningTxt
	  self.thisSubStrike = thisSubStrike
	  self.thisCalledStrike2 = thisCalledStrike2
	  self.startDate = startDate
	  self.startTime = startTime
	  self.atBat = atBat
	  self.atBatPic = atBatPic
	  self.atBatSummary = atBatSummary
   }


}
