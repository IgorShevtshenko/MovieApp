//
//  TabBar.swift
//  MovieApp
//
//  Created by Igor Ševtšenko on 04.05.2022.
//

import SwiftUI

struct CoreTabBar: View {
    @State private var selectedTab: Tab = .home
    @State private var xAxis: CGFloat = 0
    @Namespace private var animation:
    
    private let home: AnyView
    private let search: AnyView
    private let media: AnyView

    init(
        home: AnyView,
        search: AnyView,
        media: AnyView
    ) {
        self.home = home
        self.search = search
        self.media = media
    }
        
    var body: some View {
        ZStack(alignment: .center) {
            TabView(selection: $selectedTab) {
                switch selectedTab {
                case .home:
                    home
                        .ignoresSafeArea()
                case .search:
                    search
                        .ignoresSafeArea()
                case .media:
                    media
                        .ignoresSafeArea()
                }
            }
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        if tab == .search { Spacer(minLength: 0) }
                        
                        GeometryReader { proxy in
                            Button {
                                withAnimation(.spring()) {
                                    selectedTab = tab
                                    xAxis = proxy.frame(in: .global).minX
                                }
                            } label: {
                                Image(systemName: tabImage(tab))
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(tab == selectedTab ? Color.blue : Color.gray)
                                    .padding(selectedTab == tab ? 15 : 0)
                                    .background(Color.white.opacity(selectedTab == tab ? 1: 0).clipShape(Circle()))
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                                    .offset(x: proxy.frame(in: .global).minX - proxy.frame(in: .global).midX ,y: selectedTab == tab ? -50 : 0)
                            }
                            .onAppear {
                                if tab == selectedTab {
                                    xAxis = proxy.frame(in: .global).minX
                                }
                            }
                        }
                        .frame(width: 25, height: 25)
                        
                        if tab == .search { Spacer(minLength: 0) }
                    }
                }
                .padding(.horizontal, 60)
                .padding(.vertical)
                .background(Color.white.clipShape(TabBarShape(xAxis: xAxis)).cornerRadius(12))
                .padding(.horizontal, idiomIsPhone() ? nil : tabBarHorizontalPaddingForIpad())
                Spacer()
                    .frame(height: 5)
            }
        }
    }

    
    private func tabImage(_ tab: Tab) -> String {
        switch tab {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .media:
            return "newspaper"
        }
    }
    
    private func idiomIsPhone() -> Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return true
        default:
            return false
        }
    }
    
    private func tabBarHorizontalPaddingForIpad() -> CGFloat {
        return UIScreen.main.bounds.width * 0.2
    }
}

struct TabBarShape: Shape {
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct CoreTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CoreTabBar(home: AnyView(Color.red), search: AnyView(Color.green), media: AnyView(Color.blue))
    }
}
