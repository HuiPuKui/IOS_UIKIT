//
//  ViewController.swift
//  bluetoothCentral
//
//  Created by 惠蒲葵 on 2025/8/24.
//

import UIKit
import CoreBluetooth

let heartRateServiceUUID: CBUUID = CBUUID(string: "180D")
let controlPointCharacteristicUUID: CBUUID = CBUUID(string: "2A39")
let sensorLocationCharacteristicUUID: CBUUID = CBUUID(string: "2A38")
let measurementCharacteristicUUID: CBUUID = CBUUID(string: "2A37")

class ViewController: UIViewController {

    @IBOutlet weak var controlPointTextField: UITextField!
    @IBOutlet weak var sensorLocationLabel: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!
    
    var centralManager: CBCentralManager!
    var heartRatePeripheral: CBPeripheral!
    var controlPointCharacteristic: CBCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 中心设备管理器
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    @IBAction func write(_ sender: Any) {
        guard let controlPointCharacteristic = self.controlPointCharacteristic else {
            return
        }
        
        self.heartRatePeripheral.writeValue(self.controlPointTextField.text!.data(using: .utf8)!, for: controlPointCharacteristic, type: .withResponse)
    }
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("未知")
        case .resetting:
            print("重置中")
        case .unsupported:
            print("不支持BLE")
        case .unauthorized:
            print("未授权")
        case .poweredOff:
            print("蓝牙未开启")
        case .poweredOn:
            print("蓝牙开启")
            central.scanForPeripherals(withServices:nil)
            
        @unknown default:
            print("来自未来的错误")
        }
    }
    
    // 发现外设
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("发现外设")
        self.heartRatePeripheral = peripheral
        central.stopScan() // 发现之后停止扫描
        
        central.connect(peripheral)
    }
    
    // 连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接成功")
        peripheral.delegate = self
        peripheral.discoverServices([
            heartRateServiceUUID
        ])
    }
    
    // 连接失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        print("连接失败")
    }
    
    // 连接断开
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        print("连接断开")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            central.connect(peripheral)
        }
    }
    
}

extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
        if let error = error {
            print("没找到服务, 原因是: \(error.localizedDescription)")
        }
        
        guard let service = peripheral.services?.first else {
            return
        }
        
        peripheral.discoverCharacteristics([
            controlPointCharacteristicUUID,
            sensorLocationCharacteristicUUID,
            measurementCharacteristicUUID
        ], for: service)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: (any Error)?) {
        if let error = error {
            print("没找到特征, 原因是: \(error.localizedDescription)")
        }
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        for characteristic in characteristics {
            if characteristic.properties.contains(.write) {
                peripheral.writeValue("100".data(using: .utf8)!, for: characteristic, type: .withResponse)
                self.controlPointCharacteristic = characteristic
            }
            
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
            
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        if let error = error {
            print("写入失败, 原因是: \(error.localizedDescription)")
            return
        }
        
        print("写入成功")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        if let error = error {
            print("读取失败, 原因是: \(error.localizedDescription)")
            return
        }
        
        switch characteristic.uuid {
        case sensorLocationCharacteristicUUID:
            self.sensorLocationLabel.text = String(data: characteristic.value!, encoding: .utf8)
        case measurementCharacteristicUUID:
            guard let heartRate = Int(String(data: characteristic.value!, encoding: .utf8)!) else {
                return
            }
            
            self.heartRateLabel.text = "\(heartRate)"
        default:
            break
        }
    }
    
}
