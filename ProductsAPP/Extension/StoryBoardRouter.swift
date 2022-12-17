//
//  StoryBoardRouter.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import Foundation
import UIKit

enum storyboards: String {
    case Main = "Main"
    case Details = "DetailsSB"
}

func currentStoryboard(_ storyboard: storyboards) -> UIStoryboard {
    return UIStoryboard(name: storyboard.rawValue, bundle: nil)
}
