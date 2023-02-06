//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import NumbersUI
import NumbersEx
import SwiftUI
import Shared


extension ViewFactory {

    func favoriteIconView(isLoading: Binding<Bool>,
                          number: NumberRowViewEntity) -> some View {

        make {
            FavoriteIconView(isLoading: isLoading,
                             favoriteIconViewModel: AnyViewModel(
                                FavoriteIconViewModel(
                                    isFavorite: false,
                                    favoritesUseCase: injector.get(IsfavoriteNumberUseCaseType.self),
                                    saveFavoritesUseCase: injector.get(SaveFavoriteNumberUseCaseType.self),
                                    deleteFavoritesUseCase: injector.get(DeleteFavoriteNumberUseCaseType.self)
                                )
                             ),
                             number: number)
        }

    }

    func numberRow(_ number: NumberRowViewEntity) -> some View {

        make {
            NumberRow(number: number)
        }
    }

    func isPrimeView(numberValue: Int) -> some View {
        make {
            PrimeIconView(
                number: numberValue,
                viewModel: AnyViewModel(
                    PrimeIconViewModel(
                        isPrimeUseCase: IsPrimeUseCase(
                            repository: PrimeNumberRepositoryImplm(
                                remoteDS: IsPrimeRemoteDSImplm()
                            )
                        )
                    )
                )
            )
        }
    }

    func randomNumberView() -> some View {
        make {
            RandomNumberView(
                viewModel: AnyViewModel(
                    RandomNumberViewModel(
                        randomNumberUsecase: injector.get(FetchRandomNumberUseCaseType.self),
                        plusNumberUsecase: injector.get(FetchWithOperationNumberUseCaseType.self)
                    )
                )
            )
        }
    }

    func searchList(_ viewModel: AnyViewModel<FilterNumbersViewModel.Input, FilterNumbersViewModel.State>, categories: [Category]) -> some View {
        make {
            FilterNumbersView(viewModel: viewModel, categories: categories)
        }
    }
}
