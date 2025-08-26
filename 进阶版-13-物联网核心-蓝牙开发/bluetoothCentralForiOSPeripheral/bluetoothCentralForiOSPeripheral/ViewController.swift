//
//  ViewController.swift
//  bluetoothCentralForiOSPeripheral
//
//  Created by 惠蒲葵 on 2025/8/27.
//

import UIKit
import CoreBluetooth

let serviceUUID: CBUUID = CBUUID(string: "90662A31-68EE-48E4-B5B1-1B94E671C6AA")
let writeUUID: CBUUID = CBUUID(string: "1A58526F-F1EC-41BB-BC72-256D1C4E8C43")
let readUUID: CBUUID = CBUUID(string: "90912AAC-7C6D-4A31-929F-DAF79FE88066")
let notifyUUID: CBUUID = CBUUID(string: "152438DB-989C-49B9-9B51-D2288CD4A85A")

class ViewController: UIViewController {

    @IBOutlet weak var writeTextField: UITextField!
    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var notifyLabel: UILabel!
    
    var centralManager: CBCentralManager!
    var fuxinPeripheral: CBPeripheral!
    var writeCharacteristic: CBCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    @IBAction func write(_ sender: Any) {
        guard let writeCharacteristic = self.writeCharacteristic else {
            return
        }
        self.fuxinPeripheral.writeValue(self.writeTextField.text!.data(using: .utf8)!, for: writeCharacteristic, type: .withResponse)
    }
    
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown, .resetting, .unsupported, .unauthorized, .poweredOff:
            print("请检查设备")
        case .poweredOn:
            print("启动成功")
            self.centralManager.scanForPeripherals(withServices: nil)
        @unknown default:
            print("来自未来的错误")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.fuxinPeripheral = peripheral
        central.stopScan()
        central.connect(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        central.connect(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
    }
    
}

extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
        guard let service = peripheral.services?.first else {
            return
        }
        peripheral.discoverCharacteristics([writeUUID, readUUID, notifyUUID], for: service)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: (any Error)?) {
        guard let characteristics = service.characteristics else {
            return
        }
        
        for characteristic in characteristics {
            if characteristic.properties.contains(.write) {
                self.writeCharacteristic = characteristic
                peripheral.writeValue("88".data(using: .utf8)!, for: characteristic, type: .withResponse)
            }
            
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
            
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        switch characteristic.uuid {
        case readUUID:
            self.readLabel.text = String(data: characteristic.value!, encoding: .utf8)
        case notifyUUID:
            self.notifyLabel.text = String(data: characteristic.value!, encoding: .utf8)
        default:
            break
        }
    }
}
