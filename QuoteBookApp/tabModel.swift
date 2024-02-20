//
//  tabModel.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 10/11/23.
//

import Foundation
import SwiftUI

class tabModel : ObservableObject
{
    @Published var selectedTab: String = "library"
}
