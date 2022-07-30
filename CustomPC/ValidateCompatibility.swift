//
//  ValidateCompatibility.swift
//  CustomPC
//
//  Created by Kai on 2022/07/29.
//

import Foundation

class ValidateCompatibility {
    // 互換性判定メソッド
    // 互換性に問題がある場合 -> 互換性エラーメッセージ
    // 互換性に問題ない場合   -> nil
    public static func isCompatible(pcParts: [PcParts]) -> String? {
        var incompatibleMessage = ""
        var cpu :PcParts?
        var cpuCooler :PcParts?
        var memory :PcParts?
        var motherBoard :PcParts?
        
        for parts in pcParts {
            switch (parts.category) {
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
            return nil
        }
        
        // cpu mother チェック
        if let cpu = cpu {
            if (!validateSocket(cpu: cpu, motherBoard:motherBoard)) {
                // ソケット形状が異なる場合
                incompatibleMessage += "CPUとマザーボードのソケット形状"
            }
            
            if (!validateTipset(cpu: cpu, motherBoard: motherBoard)) {
                // チップセットが対応していない場合
                incompatibleMessage += "CPUとマザーボードのチップセット"
            }
        }
        
        // cpuCooler mother
        if let cpuCooler = cpuCooler {
            if (!validateSocket(cpuCooler: cpuCooler, motherBoard: motherBoard)) {
                // ソケット形状が異なる場合
                incompatibleMessage += "CPUクーラーとマザーボードのソケット形状"
            }
        }
        
        // memory mother
        if let memory = memory {
            if (!validateSocket(memory: memory, motherBoard: motherBoard)) {
                // 規格が異なる場合
                incompatibleMessage += "メモリーとマザーボードの規格"
            }
            
            if (!MemoryLessThanSlotsCapacity(memory: memory, motherBoard: motherBoard)) {
                // メモリの枚数がスロット数を超えている場合
                incompatibleMessage += "メモリーの枚数とマザーボードのスロットの数"
            }
        }
        
        if incompatibleMessage == "" {
            return incompatibleMessage
        } else {
            return nil
        }
    }
    
    private static func validateSocket(cpu:PcParts, motherBoard:PcParts) -> Bool {
        // cpuソケット情報格納例) "ソケット形状 LGA1700" -> "LGA1700"
        guard var cpuSocket = cpu.specs["socket"] else { return false }
        cpuSocket = cpuSocket.replacingOccurrences(of: "ソケット形状 ", with: "")
        
        // マザーボードソケット情報格納例) "CPUソケットLGA1700" -> "LGA1700"
        guard var motherBoardSocket = motherBoard.specs["socket"] else { return false }
        motherBoardSocket = motherBoardSocket.replacingOccurrences(of: "CPUソケット", with: "")
        
        if cpuSocket == motherBoardSocket { return true }
        
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



