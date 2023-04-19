//
//  HomeFlow.swift
//  GOMS-iOS
//
//  Created by 선민재 on 2023/04/18.
//

import RxFlow
import UIKit
import RxCocoa
import RxSwift

struct HomeStepper: Stepper{
    var steps = PublishRelay<Step>()

    var initialStep: Step{
        return GOMSStep.homeIsRequired
    }
}

class HomeFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    var stepper = HomeStepper()
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    init(){}
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GOMSStep else { return .none }
        switch step {
        case .tabBarIsRequired:
            return .end(forwardToParentFlowWithStep: GOMSStep.tabBarIsRequired)
            
        case .introIsRequired:
            return .end(forwardToParentFlowWithStep: GOMSStep.introIsRequired)
            
        case .homeIsRequired:
            return coordinateToHome()
            
        default:
            return .none
        }
    }
    
    private func coordinateToHome() -> FlowContributors {
        let vm = HomeViewModel()
        let vc = HomeViewController(vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}