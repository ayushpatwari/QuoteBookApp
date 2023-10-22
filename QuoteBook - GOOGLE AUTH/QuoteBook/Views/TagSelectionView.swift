//
//  TagSelectionView.swift
//  QuoteBook
//
//  Created by Rajeev Kumar on 8/7/23.
//

import SwiftUI




struct TagSelectionView: View {
    @ObservedObject var model = ViewModel()

    init(model: ViewModel) {
        
       

        self.model = model
    }
    var body: some View {
        ScrollView{
        TagView(tags: [TagViewItem(title: "🤗 Acceptance", isSelected: false), TagViewItem(title: "🌲 Adventure", isSelected: false), TagViewItem(title: "✨ Authenticity", isSelected: false), TagViewItem(title: "☯️ Balance", isSelected: false), TagViewItem(title: "💄 Beauty", isSelected: false), TagViewItem(title: "🙏 Belief", isSelected: false), TagViewItem(title: "🦋 Change", isSelected: false), TagViewItem(title: "☺️ Compassion", isSelected: false), TagViewItem(title: "🤝 Connection", isSelected: false), TagViewItem(title: "💪 Courage", isSelected: false), TagViewItem(title: "🎨 Creativity", isSelected: false), TagViewItem(title: "🤔 Curiosity", isSelected: false), TagViewItem(title: "😤 Determination", isSelected: false), TagViewItem(title: "👩🏼‍🤝‍👨🏾 Diversity", isSelected: false), TagViewItem(title: "💭 Dreams", isSelected: false), TagViewItem(title: "💁‍♂️ Empathy", isSelected: false), TagViewItem(title: "😲 Empowerment", isSelected: false), TagViewItem(title: "🧎‍♂️ Faith", isSelected: false), TagViewItem(title: "👨‍👩‍👦 Family", isSelected: false), TagViewItem(title: "🙃 Forgiveness", isSelected: false), TagViewItem(title: "🏃‍♂️ Freedom", isSelected: false), TagViewItem(title: "👥 Friendship", isSelected: false), TagViewItem(title: "😪 Gratitude", isSelected: false), TagViewItem(title: "☝️ Growth", isSelected: false), TagViewItem(title: "😄 Happiness", isSelected: false), TagViewItem(title: "🙆‍♀️ Harmony", isSelected: false), TagViewItem(title: "🥺 Hope", isSelected: false), TagViewItem(title: "😂 Humor", isSelected: false), TagViewItem(title: "🧚‍♀️ Imagination", isSelected: false), TagViewItem(title: "🧓 Inspiration", isSelected: false), TagViewItem(title: "🕵️‍♀️ Intuition", isSelected: false), TagViewItem(title: "😆 Joy", isSelected: false), TagViewItem(title: "😊 Kindness", isSelected: false), TagViewItem(title: "🤣 Laughter", isSelected: false), TagViewItem(title: "🥰 Love", isSelected: false), TagViewItem(title: "👍 Motivation", isSelected: false), TagViewItem(title: "😌 Patience", isSelected: false), TagViewItem(title: "✌️ Peace", isSelected: false), TagViewItem(title: "➕ Positivity", isSelected: false), TagViewItem(title: "📈 Progress", isSelected: false), TagViewItem(title: "🧐 Purpose", isSelected: false), TagViewItem(title: "💧 Reflection", isSelected: false), TagViewItem(title: "⚔️ Resilience", isSelected: false), TagViewItem(title: "😚 Serenity", isSelected: false), TagViewItem(title: "😐 Simplicity", isSelected: false), TagViewItem(title: "🤑 Success", isSelected: false), TagViewItem(title: "🌊 Tranquility", isSelected: false), TagViewItem(title: "🥺 Trust", isSelected: false), TagViewItem(title: "🤓 Wisdom", isSelected: false), TagViewItem(title: "🤩 Wonder", isSelected: false)])
    }
        .offset(x: 0, y: 40)
    }
}

struct TagSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectionView(model: ViewModel())
    }
}
