//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit
import Parma

struct VideoPlayerView: View {
    
    @StateObject private var videoPlayerViewModel: VideoPlayerViewModel = VideoPlayerViewModel(networkManager: NetworkManager())
    
    var body: some View {
        NavigationStack {
            VStack {
                if videoPlayerViewModel.isLoading {
                    VStack(alignment: .center) {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    videoPlayer
                    if !videoPlayerViewModel.videos.isEmpty {
                        videoDetailView
                    }
                }
            }
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error occured", isPresented: $videoPlayerViewModel.showAlert) {
                Button("Ok", role: .cancel) {
                    videoPlayerViewModel.showAlert = false
                }
            } message: {
                Text(videoPlayerViewModel.errorMessage)
            }

        }
    }
    
    private var videoPlayer: some View {
        VideoPlayer(player: videoPlayerViewModel.player) {
            VStack(alignment: .center) {
                HStack {
                    PlayBackButton(action: videoPlayerViewModel.previous, imageName: "previous", isDisabled: videoPlayerViewModel.disablePreviousButton, widthAndHeight: 44)
                    
                    Spacer()
                    
                    PlayBackButton(action: videoPlayerViewModel.playPause, imageName: videoPlayerViewModel.isPlaying ? "pause" : "play" , isDisabled: false, widthAndHeight: 60)
                    
                    Spacer()
                    
                    PlayBackButton(action: videoPlayerViewModel.next, imageName: "next", isDisabled: videoPlayerViewModel.disableNextButton, widthAndHeight: 44)
                }
                .padding(.horizontal, 80)
            }
        }
        .frame(height: 300)
    }
    
    private var videoDetailView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(videoPlayerViewModel.currentVideo.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                Text(videoPlayerViewModel.currentVideo.author.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .padding(.bottom, 10)
            }
            Parma(videoPlayerViewModel.currentVideo.description)
        }
        .padding(.horizontal, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
