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
        var compatibilityMessage : String?
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
            return (CompatibilityStatus.noSolution, compatibilityMessage)
        }
        
        // cpu mother チェック
        if let cpu = cpu {
            let isCompatibleSocket = false // ここで判定メソッド
            if (!isCompatibleSocket) {
                compatibilityMessage! += "CPUとマザーボードのソケット形状"
            }
            
            let isCompatibleTipset = false // ここで判定メソッド
            if (!isCompatibleTipset) {
                compatibilityMessage! += "CPUとマザーボードのチップセット"
            }
        }
        
        // cpuCooler mother
        if let cpuCooler = cpuCooler {
            let isCompatibleSocket = false // ここで判定メソッド
            if (!isCompatibleSocket) {
                compatibilityMessage = "CPUクーラーとマザーボードのソケット形状"
            }
        }
        
        // memory mother
        if let memory = memory {
            let isCompatibleSocet = false
            if (!isCompatibleSocet) {
                compatibilityMessage = "メモリーとマザーボードの規格"
            }
            
            let lessThanSlots = false
            if (!lessThanSlots) {
                compatibilityMessage = "メモリーの枚数とマザーボードのスロットの数"
            }
        }
        
        if let message = compatibilityMessage {
            return (CompatibilityStatus.incompatible, message)
        } else {
            return (CompatibilityStatus.compatible, nil)
        }
    }
}


