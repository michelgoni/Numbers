//
//  InfiniteScroll.swift
//  
//
//  Created by Michel Goñi on 6/2/23.
//

import Foundation
import Inject
import NumbersEx
import Shared
import SwiftUI

public struct InfiniteScrollView: View {
    public typealias ViewModel = AnyViewModel<RandomNumberViewModel.Input, RandomNumberViewModel.State>
    @ObservedObject public var viewModel: ViewModel
    @ObservedObject private var iO = Inject.observer
    @Namespace private var namespace
    @State private var xOffset: CGFloat = 0
    @State private var currentPage: Int = .zero
    @State var isLoading: Bool = true

    var lastPage = data.count - 1

    public init (viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    private var screenWidth = UIScreen.main.bounds.width

    public var body: some View {
       return  VStack(spacing: 20) {
            Text(verbatim: "Fun with numbers")
                .font(.system(size: 30, weight: .bold))
                .padding(.top, 50)
            ZStack {
                GeometryReader { reader in
                    HStack(spacing: .zero) {
                        ForEach(viewModel.numbers) { item in
                            NumberView(item: item)
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
                                    if currentPage != .zero {
                                        currentPage -= 1
                                    }

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
                                    viewModel.trigger(.randomNumber)
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
            .onAppear {[weak viewModel] in
                viewModel?.trigger(.randomNumber)
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
             if value.translation.width > screenWidth / 2 && currentPage < lastPage && currentPage != .zero  {
                currentPage -= 1
            }
        }
        withAnimation {
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
}

private extension InfiniteScrollView {

    func viewState(_ state: RandomNumberViewModel.ViewState?) {
        switch state {
        case .loaded:
            self.isLoading = false
        case .loading:
            self.isLoading = true
        default: break
        }
    }
}

struct Item: Identifiable, Equatable {
    let number: String = "1"
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


