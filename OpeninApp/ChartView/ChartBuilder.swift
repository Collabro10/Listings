//
//  ChartBuilder.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 13/06/23.
//

import Foundation

protocol ChartBuildable {
    func build() -> ChartInterface
}

final class ChartBuilder: ChartBuildable {
    func build() -> ChartInterface {
        let presenter: ChartPresentable = ChartView()
        let interactor: ChartInteractable = ChartInteractor(presenter: presenter)
        presenter.interactor = interactor
        return presenter
    }
}
