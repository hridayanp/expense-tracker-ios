import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var router: AppRouter
    @State private var selectedTab: Int = 0 // Track current tab
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColors.secondary)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().unselectedItemTintColor = UIColor(AppColors.primary)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(AppColors.secondary)
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
            VStack(spacing: 0) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                        }
                        .tag(0)
                    
                    StatisticsView()
                        .tabItem {
                            Image(systemName: "chart.bar.xaxis.ascending")
                        }
                        .tag(1)
                    
                    if selectedTab == 0 {
                        Spacer()
                    }
                    
                    HomeView()
                        .tabItem {
                            Image(systemName: "wallet.bifold")
                        }
                        .tag(2)
                    
                    MenuView()
                        .tabItem {
                            Image(systemName: "person")
                        }
                        .tag(3)
                }
                .accentColor(AppColors.primary)
            }
            
            // Show Plus Button only when on HomeView
            if selectedTab == 0 {
                Button(action: {
                    router.navigate(to: .expensesView)
                }) {
                    Image("plus-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(AppColors.primary)
                                .shadow(radius: 4)
                        )
                }
                .offset(y: -20)
            }
        }
    }
}

#Preview {
    MainTabView()
}
