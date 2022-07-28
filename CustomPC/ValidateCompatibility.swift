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
            return (CompatibilityStatus.compatible, nil)
        }
        
        // cpu mother チェック
        if let cpu = cpu {
            if (!validateSocket(cpu: cpu, motherBoard:motherBoard)) {
                // ソケット形状が異なる場合
                incompatibleMessage! += "CPUとマザーボードのソケット形状"
            }
            
            if (!validateTipset(cpu: cpu, motherBoard: motherBoard)) {
                // チップセットが対応していない場合
                incompatibleMessage! += "CPUとマザーボードのチップセット"
            }
        }
        
        // cpuCooler mother
        if let cpuCooler = cpuCooler {
            if (!validateSocket(cpuCooler: cpuCooler, motherBoard: motherBoard)) {
                // ソケット形状が異なる場合
                incompatibleMessage = "CPUクーラーとマザーボードのソケット形状"
            }
        }
        
        // memory mother
        if let memory = memory {
            if (!validateSocket(memory: memory, motherBoard: motherBoard)) {
                // 規格が異なる場合
                incompatibleMessage = "メモリーとマザーボードの規格"
            }
            
            if (!MemoryLessThanSlotsCapacity(memory: memory, motherBoard: motherBoard)) {
                // メモリの枚数がスロット数を超えている場合
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



