//
//  ContentView.swift
//  ArtDetective
//
//  Created by Balutoiu Rares on 04/11/2023.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @State private var isCameraPresented = false
    @State private var capturedImage: UIImage?
    @State private var showScannedArtView = false
    @State private var showExtraFeatureView = false


    var body: some View {
        NavigationView {
            VStack {
                // If an image is captured, show it with a button to navigate to more details
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Text("Captured Image")
                        .font(.headline)
                    HStack {
                            Button(action: {
                                // Set to true to navigate to the ExtraFeatureView
                                self.showExtraFeatureView = true
                            }) {
                                Text("Scan image")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                        NavigationLink(destination: ExtraFeatureView(), isActive: $showExtraFeatureView) { EmptyView() }

                        
                            Button(action: {
                                // This will clear the captured image and bring the user back to the main view
                                self.capturedImage = nil
                            }){
                                Text("Back")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                        }
                        .padding()
                    // Invisible NavigationLink activated by the state variable
                    NavigationLink(destination: ScannedArtView(image: capturedImage!), isActive: $showScannedArtView) { EmptyView() }
                } else {
                    // Main view when no image is captured
                    HStack {
                        Text("ArtDetective")
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                        
                        Image("logo-no-background") // Replace with your actual logo image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                    }
                    
                    Spacer(minLength: 2)
                    
                    Button(action: {
                        // Trigger camera view presentation
                        self.isCameraPresented = true
                    }) {
                        VStack {
                            Text("Scan")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Image("scan") // Replace with your actual scan button image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 100)
                        }
                    }
                    .padding(10)
                    .fullScreenCover(isPresented: $isCameraPresented) {
                        ScanArtView(isPresented: $isCameraPresented, capturedImage: $capturedImage)
                    }
                    
                    // Rest of your buttons for Search and Extra features
                    NavigationLink(destination: SearchView()) {
                        VStack {
                            Text("Search")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Image("search-icon") // Replace with your actual search icon image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 100)
                        }
                    }
                    .padding(10)
                    
                    
                    /*NavigationLink(destination: ExtraFeatureView()) {
                        VStack {
                            Text("Paint")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Image("Paintbrush") // Replace with your actual extra feature icon image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 100)
                        }
                    }
                    .padding(10)*/
                }
            }
        }
    }
}



