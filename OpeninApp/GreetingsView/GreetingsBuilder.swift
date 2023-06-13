//
//  GreetingsBuilder.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 12/06/23.
//

import Foundation

protocol GreetingsBuildable {
    func build() -> GreetingsInterface
}

final class GreetingsBuilder: GreetingsBuildable {
    func build() -> GreetingsInterface {
        let presentable: GreetingsPresentable = GreetingsView()
        let interactor: GreetingsInteractable = GreetingsInteractor(presenter: presentable)
        presentable.interactor = interactor
        return presentable
    }
}

