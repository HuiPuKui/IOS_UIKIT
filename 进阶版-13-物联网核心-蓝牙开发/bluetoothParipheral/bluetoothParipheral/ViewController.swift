//
//  ViewController.swift
//  bluetoothParipheral
//
//  Created by 惠蒲葵 on 2025/8/26.
//

import UIKit
import CoreBluetooth

let serviceUUID: CBUUID = CBUUID(string: "90662A31-68EE-48E4-B5B1-1B94E671C6AA")
let writeUUID: CBUUID = CBUUID(string: "1A58526F-F1EC-41BB-BC72-256D1C4E8C43")
let readUUID: CBUUID = CBUUID(string: "90912AAC-7C6D-4A31-929F-DAF79FE88066")
let notifyUUID: CBUUID = CBUUID(string: "152438DB-989C-49B9-9B51-D2288CD4A85A")

class ViewController: UIViewController {

    @IBOutlet weak var writeLabel: UILabel!
    @IBOutlet weak var readLebel: UILabel!
    @IBOutlet weak var nodifyLabel: UILabel!
    
    var peripheralManager: CBPeripheralManager!
    var writeCharacteristic: CBMutableCharacteristic!
    var readCharacteristic: CBMutableCharacteristic!
    var notifyCharacteristic: CBMutableCharacteristic!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .unknown:
            print("未知状态")
        case .resetting:
            print("重置中")
        case .unsupported:
            print("不支持低能耗蓝牙(BLE)")
        case .unauthorized:
            print("未授权")
        case .poweredOff:
            print("蓝牙未开启")
        case .poweredOn:
            print("蓝牙开启")
            
            let service = CBMutableService(type: serviceUUID, primary: true)
            self.writeCharacteristic = CBMutableCharacteristic(
                type: writeUUID,
                properties: .write,
                value: nil,
                permissions: .writeable
            )
            self.readCharacteristic = CBMutableCharacteristic(
                type: readUUID,
                properties: .read,
                value: nil,
                permissions: .readable
            )
            self.notifyCharacteristic = CBMutableCharacteristic(
                type: notifyUUID,
                properties: .notify,
                value: nil,
                permissions: .readable
            )
            service.characteristics = [
                writeCharacteristic, readCharacteristic, notifyCharacteristic
            ]
            self.peripheralManager.add(service)
            self.peripheralManager.startAdvertising([
                CBAdvertisementDataServiceUUIDsKey:[serviceUUID]
            ])
        @unknown default:
            print("来自未来的错误")
        }
    }
    
    // 当在外设管理器中添加服务时
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: (any Error)?) {
        if let error = error {
            print("无法添加服务, 原因是: \(error.localizedDescription)")
        }
    }
    
    // 开始广播后
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: (any Error)?) {
        if let error = error {
            print("无法开始广播, 原因是: \(error.localizedDescription)")
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        let request = requests[0]
        if request.characteristic.properties.contains(.write) {
            self.writeCharacteristic.value = request.value
            self.writeLabel.text = String(data: request.value!, encoding: .utf8)
            peripheral.respond(to: request, withResult: .success)
        } else {
            peripheral.respond(to: request, withResult: .writeNotPermitted)
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        if request.characteristic.properties.contains(.read) {
            request.value = self.readLebel.text!.data(using: .utf8)
            peripheral.respond(to: request, withResult: .success)
        } else {
            peripheral.respond(to: request, withResult: .readNotPermitted)
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        updateNotifyValue()
    }
    
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        updateNotifyValue()
    }
    
    // 当中心设备取消某个订阅时
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        self.timer?.invalidate()
    }
    
    func updateNotifyValue() {
        
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { (timer) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年MM月dd日 HH时mm分ss秒"
            
            let dateStr = dateFormatter.string(from: Date())
            
            self.nodifyLabel.text = dateStr
            
            self.peripheralManager.updateValue(
                dateStr.data(using: .utf8)!,
                for: self.notifyCharacteristic,
                onSubscribedCentrals: nil
            )
        }
        
    }
    
}
