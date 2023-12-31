//CREATED BY RITHIK KUMAR

import SwiftUI

struct TagViewItem: Hashable {
    var title: String
    var isSelected: Bool
    
    static func == (lhs: TagViewItem, rhs: TagViewItem) -> Bool {
        return lhs.isSelected == rhs.isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(isSelected)
    }
}

struct TagView: View {
    @State var tags: [TagViewItem]
    @State private var totalHeight = CGFloat.zero

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var selectedTagCount = tags.filter { $0.isSelected }.count // Track the number of selected tags
        return ZStack(alignment: .topLeading) {
            ForEach(tags.indices) { index in
                item(for: tags[index].title, isSelected: tags[index].isSelected)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tags[index].title == self.tags.last!.title {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tags[index].title == self.tags.last!.title {
                            height = 0
                        }
                        return result
                    })
                    .onTapGesture {
                        if selectedTagCount < 3 || tags[index].isSelected == true {
                            tags[index].isSelected.toggle()
                            selectedTagCount += tags[index].isSelected ? 1 : -1
                        }
                    }
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String, isSelected: Bool) -> some View {
        Text(text)
            .bold()
            .foregroundColor(isSelected ? Color(#colorLiteral(red: 0.1340637264, green: 0.6421895015, blue: 0.7360979563, alpha: 1)) : Color.white)
            .padding()
            .lineLimit(1)
            .background(isSelected ? Color(#colorLiteral(red: 0, green: 0.301058143, blue: 0.5746451229, alpha: 1)) : Color(#colorLiteral(red: 0.2903293967, green: 0.2863105237, blue: 0.2821627259, alpha: 1)))
            .frame(height: 36)
            .cornerRadius(18)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
