//
//  FrameworkDetailViewModel.swift
//  AppleFrameWork
//
//  Created by 오예진 on 2022/10/07.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
    
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
    // Data -> output
    let framework: CurrentValueSubject<AppleFramework, Never>
    
    
    // User Action -> input
    
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }
}
