//TabBar.swift

//TabBar
/* Todoist (by priority - do BARE MINIMUM)
 1. Get SF symbols animated
 2. Link it to other files
 3. Only appears on certain windows (prob only a window that is included in the tabs) */


import SwiftUI

enum Tabs: Int {
    case home = 1
    case discover = 2
    case collections = 3
    case library = 4
    
}

struct TabBar: View {
    @State private var selectedTab: Tabs = .discover
    @State private var selectedLibrary = false
    @State private var showingAddView = false
    
    
    
    var body: some View {
        
        VStack {
            Spacer()
            
            //MARK: Blur Container
            ZStack {
                BlurView(style: .systemUltraThinMaterial)
                    .frame(height: 65)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(35)
                    .padding(.horizontal, 10)
                
                
                HStack(alignment:.center) {
                    
                    Spacer()
                    
                    //MARK: Home
                    Group{
                        ZStack{
                            if selectedTab == .home{
                                indicator()
                                
                            }
                            Button {
                                selectedTab = .home
                                
                            } label: {
                                Image(systemName: "house")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 33, height: 33)
                                    .opacity(selectedTab == .home ? 1 : 0.5)
                                
                            }
                        }
                        
                        Spacer()
                    }
                    
                    //MARK: Discover
                    
                    Group{
                        ZStack{
                            
                            if selectedTab == .discover{
                                indicator()
                                
                            }
                            
                            Button {
                                selectedTab = .discover
                            } label: {
                                Image(systemName: "safari")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 33, height: 33)
                                    .opacity(selectedTab == .discover ? 1 : 0.5)
                                
                            }
                        }
                        Spacer()
                    }
                    
                    //MARK: FAB
                    Group{
                        ZStack{
                            Button {
                                
                                if selectedTab == .library{
                                    showingAddView.toggle()
                                }
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(#colorLiteral(red: 0.09330444783, green: 0.6119003892, blue: 0.9225755334, alpha: 1)))
                                        .frame(width: 55, height: 55)
                                    Group{
                                        //💩 replace with "sparkle.magnifyingglass"
                                        if selectedTab == .discover{
                                            Image(systemName: "sparkle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 33, height: 33)
                                                .foregroundColor(.white)
                                        }
                                        if selectedTab == .collections{
                                            Image(systemName: "plus.square.on.square")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 33, height: 33)
                                                .foregroundColor(.white)
                                        }
                                        //💩 replace with  "pencil.and.scrible" or quote.opening
                                        if selectedTab == .library{
                                            Image(systemName: "quote.bubble")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 33, height: 33)
                                                .foregroundColor(.white)
                                        }
                                        if selectedTab == .home{
                                            Image(systemName: "gear")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 33, height: 33)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        Spacer()
                    }
                    
                    
                    //MARK: Collections
                    Group{
                        ZStack{
                            
                            if selectedTab == .collections{
                                indicator()
                            }
                            Button {
                                selectedTab = .collections
                            } label: {
                                // 💩 "square.filled.on.square" or "square.text.square"
                                Image(systemName: "square.on.square")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 33, height: 33)
                                    .opacity(selectedTab == .collections ? 1 : 0.5)
                            }
                        }
                        Spacer()
                    }
                    
                    //MARK: Library
                    Group{
                        ZStack{
                            if selectedTab == .library{
                                indicator()
                                
                            }
                            Button {
                                selectedTab = .library
                                
                            } label: {
                                //💩 "book.closed.circle"
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25, height: 25)
                                    .opacity(selectedTab == .library ? 1 : 0.5)
                            }
                        }
                        Spacer()
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddQuoteView()
        }
        .padding()
    }
}





struct indicator: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.blue)
            .frame(width: 34, height: 5)
            .offset(y: -25)
    }
}





struct icons: View {
    var imageInput: String
    
    var body: some View {
        Image(imageInput)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 25, height: 25)
    }
}





struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
    }
}





struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
        
    }
}
