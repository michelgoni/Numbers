////
////  FavoriteRow.swift
////  Numbers
////
////  Created by Michel Goñi on 30/12/22.
////
//
//import NumbersEx
//import SwiftUI
//
//private extension CGFloat {
//    static let deleteButtonSize = 30.0
//}
//
//struct FavoriteRow: View {
//    let number: NumberEntity
//    private typealias ViewModel = AnyViewModel<FavoritesViewModel.Input, FavoritesViewModel.State>
//    @EnvironmentObject private var viewModel: ViewModel
//    var body: some View {
//        VStack {
//            HStack {
//                Text(
//                    number.numberValue)
//                .modifier(
//                    NumberModifier()
//                )
//                Text(
//                    number.numberFact)
//                .padding()
//            }
//            HStack {
//                Spacer()
//                deleteButton()
//                    .frame(
//                        width: .deleteButtonSize,
//                        height: .deleteButtonSize)
//            }
//            .padding()
//            
//        }
//    }
//
//    private func deleteButton() -> some View {
//
//        return Button(action: {
//            viewModel.trigger(.delete(number))
//        }, label: {
//            Image(systemName: "trash.fill")
//        })
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//struct FavoriteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteRow(
//            number: NumberEntity(
//                isFavorite: true,
//                isPrime: true,
//                numberValue: "1",
//                numberFact: " is the number of timesthat this test is going to pass")
//        )
//        .environmentObject(
//            AnyViewModel(
//                FavoritesViewModel()
//            )
//        )
//    }
//}
