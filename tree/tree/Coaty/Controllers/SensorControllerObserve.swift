//
//  SensorControllerObserve.swift
//  tree
//
//  Created by Nikolai Madlener on 19.11.23.
//

import Foundation

//class SensorControllerObserve: Controller {
//
//    override func onCommunicationManagerStarting() {
//        super.onCommunicationManagerStarting()
//
//        self.observe()
//    }
//    
//    private func observe() {
//        try! self.communicationManager
//            .observeAdvertise(withObjectType: CoatyTree.objectType)
//            .subscribe(onNext: { event in
//                let object = event.data.object as! CoatyTree
////                Model.shared.tasks.append(object)
//            })
//            .disposed(by: self.disposeBag)
//    }
//}
