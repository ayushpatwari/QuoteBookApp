//
//  CollectionView.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 7/18/23.
//

import SwiftUI

struct CollectionView: View {
    var collection: Collection
    var body: some View {
        ScrollView {
            Text(collection.name)
        }
    }
}

#Preview {
    CollectionView(collection: Collection.all[0])
}
