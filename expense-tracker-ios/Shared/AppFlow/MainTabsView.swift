import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var router: AppRouter
    
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
                .allowsHitTesting(false) // ❌ Disables touch interactions outside active elements
            
            VStack(spacing: 0) {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "cloud.sun")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .tag(0)
                    
                    StatisticsView()
                        .tabItem {
                            Image(systemName: "chart.bar.xaxis.ascending")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .tag(1)
                    
                    Spacer()
                    
                    HomeView()
                        .tabItem {
                            Image(systemName: "wallet.bifold")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .tag(2)
                    
                    MenuView()
                        .tabItem {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .tag(3)
                }
                .accentColor(AppColors.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Floating Plus Button
            Button(action: {
                print("CLICKED") // Prints to console on tap
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

#Preview {
    MainTabView()
}
