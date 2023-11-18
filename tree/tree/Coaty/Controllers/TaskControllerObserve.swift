//
//  TaskControllerObserve.swift
//  tree
//
//  Created by Nikolai Madlener on 18.11.23.
//

import Foundation
import CoatySwift

class TaskControllerObserve: Controller {

    override func onCommunicationManagerStarting() {
        super.onCommunicationManagerStarting()

        self.observe()
    }
    
    private func observe() {
        try! self.communicationManager
            .observeAdvertise(withObjectType: TreeTask.objectType)
            .subscribe(onNext: { event in
                let object = event.data.object as! TreeTask
                Model.shared.tasks.append(object)
            })
            .disposed(by: self.disposeBag)
    }
}
