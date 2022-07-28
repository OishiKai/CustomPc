//
//  ValidateCompatibility.swift
//  CustomPC
//
//  Created by Kai on 2022/07/29.
//

import Foundation

enum CompatibilityStatus : String {
    case compatible = "選択されたパーツの互換性に問題ありません"
    case incompatible = "選択されたパーツの互換性に問題があります"
    case noSolution = "選択されたパーツは互換性に依存しません"
}

class ValidateCompatibility {
    public static func isCompatible(pcParts: [PcParts]) -> (CompatibilityStatus, String?) {
        var incompatibleMessage : String?
        var cpu :PcParts?
        var cpuCooler :PcParts?
        var memory :PcParts?
        var motherBoard :PcParts?
        
        for parts in pcParts {
            switch (parts.category){
            case .cpu:
                cpu = parts
            case .cpuCooler:
                cpuCooler = parts
            case .memory:
                memory = parts
            case .motherBoard:
                motherBoard = parts
            default : break
            }
        }
        
        // マザーボードが選ばれていない場合
        guard let motherBoard = motherBoard else {
            return (CompatibilityStatus.noSolution, incompatibleMessage)
        }
        
        // cpu mother チェック
        if let cpu = cpu {
            let isCompatibleSocket = validateSocket(cpu: cpu, motherBoard:motherBoard)
            if (!isCompatibleSocket) {
                incompatibleMessage! += "CPUとマザーボードのソケット形状"
            }
            
            let isCompatibleTipset = validateTipset(cpu: cpu, motherBoard: motherBoard)
            if (!isCompatibleTipset) {
                incompatibleMessage! += "CPUとマザーボードのチップセット"
            }
        }
        
        // cpuCooler mother
        if let cpuCooler = cpuCooler {
            let isCompatibleSocket = validateSocket(cpuCooler: cpuCooler, motherBoard: motherBoard)
            if (!isCompatibleSocket) {
                incompatibleMessage = "CPUクーラーとマザーボードのソケット形状"
            }
        }
        
        // memory mother
        if let memory = memory {
            let isCompatibleSocet = validateSocket(memory: memory, motherBoard: motherBoard)
            if (!isCompatibleSocet) {
                incompatibleMessage = "メモリーとマザーボードの規格"
            }
            
            let lessThanSlots = MemoryLessThanSlotsCapacity(memory: memory, motherBoard: motherBoard)
            if (!lessThanSlots) {
                incompatibleMessage = "メモリーの枚数とマザーボードのスロットの数"
            }
        }
        
        if let message = incompatibleMessage {
            return (CompatibilityStatus.incompatible, message)
        } else {
            return (CompatibilityStatus.compatible, nil)
        }
    }
    
    private static func validateSocket(cpu:PcParts, motherBoard:PcParts) -> Bool {
        return false
    }
    
    private static func validateTipset(cpu:PcParts, motherBoard:PcParts) -> Bool{
        return false
    }
    
    private static func validateSocket(cpuCooler:PcParts, motherBoard:PcParts) -> Bool {
        return false
    }
    
    private static func validateSocket(memory:PcParts, motherBoard:PcParts) -> Bool {
        return false
    }
    
    private static func MemoryLessThanSlotsCapacity(memory:PcParts, motherBoard:PcParts) -> Bool {
        return false
    }
}



