//
//  CongratulationsView.swift
//  TestCamera
//
//  Created by Junjie Cen on 09/11/2023.
//

import SwiftUI

struct CongratulationsView: View {
    @State private var isShowingScannedArtView = false
    var body: some View {
        VStack {
            Text("Congratulations! you have learned the Sfumato technique")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                
            // Add more content or animations as needed
            Button(action: {
                // Skip this painting part and navigate to ScannedArtView
                isShowingScannedArtView = true
            }) {
                Text("Continue")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
            
            NavigationLink("", destination: ScannedArtView(image: UIImage(named: "Mona_Lisa,_by_Leonardo_da_Vinci,_from_C2RMF")!), isActive: $isShowingScannedArtView)
                .opacity(0)
        }
    }
}
