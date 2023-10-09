//ContentView.swift

//TabBar
/* Todoist (by priority - do BARE MINIMUM)
 1. Get SF symbols animated
 2. Link it to other files
 3. Only appears on certain windows (prob only a window that is included in the tabs) */


import SwiftUI

enum Tabs: Int {
    case collections = 0
    case discover = 1
    case profile = 2
    case library = 3
    
}

struct TabBar: View {
    @State private var selectedTab: Tabs = .discover
    
    @State private var animateDiscover = false
    @State private var animateCollections = false
    @State private var animateLibrary = false
    @State private var animateProfile = false
    
    
    
    var body: some View {
        
        VStack {
            Spacer()
            
            //MARK: Blur Container
            ZStack {
                BlurView(style: .systemUltraThinMaterial)
                    .frame(height: 49)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(25)
                    .padding(.horizontal, 14)
                
                
                HStack(alignment:.center) {
                    
                    Spacer()
                    //MARK: Discover
                    Group{
                        ZStack{
                            
                            if selectedTab == .discover{
                                indicator()
                                
                            }
                            
                            Button {
                                selectedTab = .discover
                                animateDiscover.toggle()
                            } label: {
                                Image(systemName: "safari")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .opacity(selectedTab == .discover ? 1 : 0.5)
                                    
                                
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
                                    .frame(width: 24, height: 24)
                                    .opacity(selectedTab == .collections ? 1 : 0.5)
                            }
                        }
                        Spacer()
                    }
                    //MARK: FAB
                    Group{
                        ZStack{
                            Button {
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(#colorLiteral(red: 0.09330444783, green: 0.6119003892, blue: 0.9225755334, alpha: 1)))
                                        .frame(width: 40, height: 40)
                                    Group{
                                        //💩 replace with "sparkle.magnifyingglass"
                                        if selectedTab == .discover{
                                            Image(systemName: "sparkle.magnifyingglass")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.white)
                                        }
                                        if selectedTab == .collections{
                                            Image(systemName: "plus.square.on.square")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.white)
                                        }
                                        //💩 replace with  "pencil.and.scrible" or quote.opening
                                        if selectedTab == .library{
                                            Image(systemName: "quote.bubble")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.white)
                                        }
                                        if selectedTab == .profile{
                                            Image(systemName: "gear")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                }
                                
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
                                    .frame(width: 18, height: 18)
                                    .opacity(selectedTab == .library ? 1 : 0.5)
                            }
                        }
                        Spacer()
                    }
                    //MARK: Profile
                    Group{
                        ZStack{
                            if selectedTab == .profile{
                                indicator()
                                
                            }
                            Button {
                                selectedTab = .profile
                                
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .opacity(selectedTab == .profile ? 1 : 0.5)
                                
                            }
                        }
                        
                        Spacer()
                    }
                }
                
            }
        }
        .padding()
    }
}





struct indicator: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.blue)
            .frame(width: 25, height: 5)
            .offset(y: -18)
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

