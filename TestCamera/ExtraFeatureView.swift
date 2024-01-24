import SwiftUI

struct ExtraFeatureView: View {
    @State private var opacity: Double = 0.01
    @State private var hasUserStartPainting = false
    @State private var isShowingScannedArtView = false // State to control navigation
    @State private var hasFinishedPainting = false // State to track if the user has finished painting
    @State private var tapCounter = 0 // Track the number of taps

    var body: some View {
        NavigationView {
            VStack {
                Text("Sfumato technique uses soft, careful brush moves, now you turn!")
                ZStack {
                    Image("Mona_Lisa,_by_Leonardo_da_Vinci,_from_C2RMF") // Load your finished image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(opacity)
                        .gesture(
                            DragGesture().onChanged { gesture in
                                let translation = gesture.translation
                                let magnitude = sqrt(translation.width * translation.width + translation.height * translation.height)

                                // You can adjust the sensitivity by changing the magnitude threshold
                                let sensitivity: CGFloat = 10.0

                                if magnitude > sensitivity {
                                    increaseOpacity(by: 0.010)
                                    if opacity >= 1.0 {
                                        hasFinishedPainting = true
                                        print("Opacity is 1.0")
                                    }
                                }
                            }
                            .simultaneously(with: TapGesture(count: 1).onEnded { _ in
                                // Increment the tap counter
                                tapCounter += 1
                                if tapCounter > 3 {
                                    // Show a pop-up message when more than three taps
                                    showAlert()
                                    tapCounter = 0
                                }
                            })
                        )
                }
                ProgressView(value: opacity, total: 1)

                Button(action: {
                    // Skip this painting part and navigate to ScannedArtView
                    isShowingScannedArtView = true
                }) {
                    Text(hasUserStartPainting ? "Quit" : "Skip")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }

                // NavigationLink to navigate to ScannedArtView using the value parameter
                NavigationLink("", destination: ScannedArtView(image: UIImage(named: "Mona_Lisa,_by_Leonardo_da_Vinci,_from_C2RMF")!), isActive: $isShowingScannedArtView)
                    .opacity(0)

                NavigationLink("", destination: CongratulationsView(), isActive: $hasFinishedPainting)
                    .opacity(0)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }

    func increaseOpacity(by amount: Double) {
        if opacity < 1.0 {
            hasUserStartPainting = true
            tapCounter = 0
            opacity += amount
            if opacity > 1.0 {
                opacity = 1.0
            }
        }
    }

    func showAlert() {
        // Show a pop-up message when more than three taps
        let alert = UIAlertController(
            title: "This is not Sfumato technique!",
            message: "Try short, gentle swipes.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

//struct ExtraFeatureView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExtraFeatureView()
//    }
//}
