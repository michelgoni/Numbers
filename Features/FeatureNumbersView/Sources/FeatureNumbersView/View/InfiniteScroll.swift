//
//  InfiniteScroll.swift
//  
//
//  Created by Michel Goñi on 6/2/23.
//

import Inject
import Foundation
import SwiftUI

public struct InfiniteScrollView: View {
    @ObservedObject private var iO = Inject.observer
    @Namespace private var namespace
    @State private var xOffset: CGFloat = 0
    @State private var currentPage: Int = .zero
    var lastPage = data.count - 1
    var firstPage: Int = .zero

    public init () {}

    private var screenWidth = UIScreen.main.bounds.width

    public var body: some View {
        VStack(spacing: 20) {
            Text(verbatim: "Fun with numbers")
                .font(.system(size: 30, weight: .bold))
                .padding(.top, 50)
            ZStack {
                GeometryReader { reader in
                    HStack(spacing: .zero) {
                        ForEach(data) { item in
                            ItemView(item: item)
                                .frame(width: screenWidth)
                        }
                    }
                    .offset(x: xOffset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onChanged(value: value)
                            })
                            .onEnded({ value in
                                onEnded(value: value)
                            })
                    )
                }
                VStack(spacing: 20) {
                    Spacer()
                    ZStack {
                        HStack(spacing: 6) {
                            if currentPage != lastPage {

                                Button {
                                    currentPage -= 1
                                    withAnimation {
                                        xOffset = -screenWidth * CGFloat(currentPage)
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "arrow.left")
                                        Text("Previous")
                                    }
                                    .font(.system(size: 17, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                }
                                .frame(height: 60)
                                .foregroundColor(.black)

                                Button {
                                    currentPage += 1
                                    withAnimation {
                                        xOffset = -screenWidth * CGFloat(currentPage)
                                    }
                                } label: {
                                    HStack {
                                        Text("Next")
                                        Image(systemName: "arrow.right")
                                    }
                                    .font(.system(size: 17, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                }
                                .frame(height: 60)
                                .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal)
                    }

                }

            }
        }.enableInjection()
    }

    private func onChanged(value: DragGesture.Value) {
        xOffset = value.translation.width - (screenWidth * CGFloat(currentPage))
    }

    private func onEnded(value: DragGesture.Value) {
        if -value.translation.width > screenWidth / 2 && currentPage < lastPage {
            currentPage += 1
        } else {
            if value.translation.width > screenWidth / 2 && currentPage > lastPage {
                currentPage -= 1
            }
        }
        withAnimation {
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
}

struct Item: Identifiable {
    let id = UUID().uuidString
    let subtitle: String
}

let data = [
    Item(subtitle: "Subtitle 1 with a long loong text with at least two lines"),
    Item(subtitle: "Subtitle 2 with a long loong text with at least two lines"),
    Item(subtitle: "Subtitle 3 with a long loong text with at least two lines"),
    Item(subtitle: "Subtitle 4 with a long loong text with at least two lines"),
    Item(subtitle: "Subtitle 5 with a long loong text with at least two lines"),
    Item(subtitle: "Subtitle 6 with a long loong text with at least two lines"),
    Item(subtitle: "Subtitle 7 with a long loong text with at least two lines"),
    Item(subtitle: "Subtitle 8 with a long loong text with at least two lines")
]

struct ItemView: View {
    let item: Item
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 15) {

                Spacer()
                Text(verbatim: item.subtitle)
                    .font(.system(size: 25, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .animation(.interpolatingSpring(stiffness: 40, damping: 5))
                Image(systemName: "swift")
                    .font(.system(size: 75, weight: .light))
                    .padding(.top, 30)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth:.infinity, maxHeight: UIScreen.main.bounds.height / 1.6, alignment: .center)
        }
    }
}
