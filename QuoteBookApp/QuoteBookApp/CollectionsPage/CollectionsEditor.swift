//
//  CollectionsEditor.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 7/8/23.
//

import SwiftUI

struct CollectionsEditor: View {
    var collection: Collection
    var body: some View {
        ScrollView {
            Text(collection.name)
        }
    }
}

