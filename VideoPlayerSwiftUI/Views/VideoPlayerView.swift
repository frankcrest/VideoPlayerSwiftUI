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
                VideoPlayer(player: videoPlayerViewModel.player) {
                    VStack(alignment: .center) {
                        HStack {
                            Button(action: {
                                videoPlayerViewModel.previous()
                            }, label: {
                                Image("previous")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .overlay {
                                       Circle()
                                            .stroke(.black, lineWidth: 1.0)
                                    }
                            })
                            .disabled(videoPlayerViewModel.disablePreviousButton)
                            
                            Spacer()
                            
                            Button(action: {
                                videoPlayerViewModel.playPause()
                            }, label: {
                                Image(videoPlayerViewModel.isPlaying ? "pause" : "play")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .overlay {
                                       Circle()
                                            .stroke(.black, lineWidth: 1.0)
                                    }
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                videoPlayerViewModel.next()
                            }, label: {
                                Image("next")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .overlay {
                                       Circle()
                                            .stroke(.black, lineWidth: 1.0)
                                    }
                            })
                            .disabled(videoPlayerViewModel.disableNextButton)
                        }
                        .padding(.horizontal, 80)
                    }
                }
                .frame(height: 300)
                
                if !videoPlayerViewModel.videos.isEmpty {
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
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
