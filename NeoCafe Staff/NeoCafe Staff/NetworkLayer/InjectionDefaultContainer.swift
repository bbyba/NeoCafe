//
//  InjectionDefaultContainer.swift
//  NeoCafe Staff
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
