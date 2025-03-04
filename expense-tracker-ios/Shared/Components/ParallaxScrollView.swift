import SwiftUI

struct ParallaxScrollView<Content: View>: View {
    private let imageHeight: CGFloat = 300 // Background image height
    
    @State private var offset: CGFloat = 0
    let backgroundImage: String
    let content: Content
    
    init(backgroundImage: String, @ViewBuilder content: () -> Content) {
        self.backgroundImage = backgroundImage
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // Parallax Background Image
                    GeometryReader { proxy in
                        Image(backgroundImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: imageHeight)
                            .offset(y: scrollOffset(proxy))
                            .scaleEffect(scaleFactor(proxy))
                    }
                    .frame(height: imageHeight) // Keeps space for the image
                    
                    // Content Area
                    ZStack {
                        Rectangle()
                            .fill(AppColors.secondary)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: -16)
                        
                        content
                            .frame(maxHeight: .infinity, alignment: .top)
                            .padding()
                    }
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .global).minY)
                    }
                )
            }
            .coordinateSpace(name: "ScrollView")
            .onPreferenceChange(OffsetPreferenceKey.self) { value in
                offset = value
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
    // **Parallax Scroll Effect**
    private func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .global).minY
        return minY < 0 ? minY * 0.5 : 0 // Moves slower when scrolled up
    }
    
    // **Scale Effect on Pull Down**
    private func scaleFactor(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .global).minY
        return minY > 0 ? 1 + (minY / 300) : 1 // Scales up when pulled down
    }
}

// Tracks Scroll Offset
struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
