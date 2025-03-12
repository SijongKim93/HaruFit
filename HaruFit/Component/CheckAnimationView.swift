import SwiftUI
import Lottie

struct CheckAnimationView: View {
    @State private var shouldPlayAnimation: Bool = false

    var body: some View {
        LottieView(animation: .named("Check"))
            .playbackMode(
                shouldPlayAnimation
                ? .playing(.toProgress(1, loopMode: .playOnce))
                : .playing(.toProgress(0, loopMode: .playOnce))
            )
            .configure { lottieAnimationView in
                lottieAnimationView.contentMode = .scaleAspectFit
            }
            .animationDidFinish { completed in
                print("애니메이션이 완료되었습니다. completed: \(completed)")
            }
            .frame(width: 300, height: 300)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    shouldPlayAnimation = true
                }
            }
    }
}
