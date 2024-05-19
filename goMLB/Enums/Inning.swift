//   Inning.swift
//   goMLB
//
//   Created by: Grant Perry on 5/18/24 at 1:09 PM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

enum Inning: String {
   case top = "arrowtriangle.up"
   case bottom = "arrowtriangle.down"
   case middle = "repeat.circle"
   case unknown = "questionmark.bubble"
}

func getInningSymbol(inningTxt: String) -> Inning {
   if inningTxt.contains("Top") {
	  return .top
   } else if inningTxt.contains("Bottom") {
	  return .bottom
   } else if inningTxt.contains("Middle") {
	  return .middle
   } else {
	  return .unknown
   }
}

