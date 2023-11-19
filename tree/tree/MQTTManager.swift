//
//  MQTTManager.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-01-19.
//

import Foundation

import CocoaMQTT
import Combine

class MQTTManager: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("did connect ack")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("did publish ack")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("did ping")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("did receive pong")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("mqtt did disconnect \(err.debugDescription)")
    }
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Message received in topic \(message.topic) with payload \(message.string!)")

    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Message published in topic \(message.topic) with payload \(message.string!)")

    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print("sub")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("unsub")
    }
    
    let mqtt = CocoaMQTT(clientID: "sandesh", host: "mqtt.eclipseprojects.io", port: 1883)
    
    init() {
        mqtt.delegate = self
        mqtt.logLevel = .debug
        let connected = mqtt.connect()
        if connected {
            print("connected!")
        }
    
//        mqtt.didReceiveMessage = { mqtt, message, id in
//            print("Message received in topic \(message.topic) with payload \(message.string!)")
//            
//           
//        }
        //let res = mqtt.publish("hello/world/vincent", withString: "helloworld", qos: .qos1)
        //print(res)
        //mqtt.subscribe("oq75d6d7d31777e47cf22c81c2314b028/sensor/klmnopqrstuvwxyza_moisture/state", qos: .qos2)

    }
}
