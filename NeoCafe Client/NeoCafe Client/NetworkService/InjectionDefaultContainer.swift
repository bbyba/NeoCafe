//
//  InjectionDefaultContainer.swift
//  NeoCafe Client
//

import Factory

typealias InjectionDefaultContainer = Container
typealias InjectionFactory = Factory
typealias InjectionInjected = Injected

extension InjectionDefaultContainer {
    var networkService: InjectionFactory<NetworkServiceProtocol> {
        self { NetworkService() }
    }
}
