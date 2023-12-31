//
//  PCParts.swift
//  CustomPC
//
//  Created by Kai on 2022/04/13.
//

import Foundation

enum Category: String {
    case cpu = "CPU"
    case cpuCooler = "CPUクーラー"
    case memory = "メモリー"
    case motherBoard = "マザーボード"
    case graphicsCard = "グラフィックボード・ビデオカード"
    case ssd = "SSD"
    case hdd = "ハードディスク・HDD"
    case pcCase = "PCケース"
    case powerUnit = "電源ユニット"
    case caseFan = "ケースファン"
    case monitor = "PCモニター・液晶ディスプレイ"
    
    func startPageUrl() -> String{
        switch self {
        case .cpu:
            return "https://kakaku.com/search_results/cpu/?category=0001"
        case .cpuCooler:
            return "https://kakaku.com/search_results/cpu%83N%81%5B%83%89%81%5B/?category=0001"
        case .memory:
            return "https://kakaku.com/search_results/ddr4%83%81%83%82%83%8A/?category=0001"
        case .motherBoard:
            return "https://kakaku.com/search_results/%83%7D%83U%81%5B%83%7B%81%5B%83h/?category=0001"
        case .graphicsCard:
            return "https://kakaku.com/search_results/%83O%83%89%83t%83B%83b%83N%83%7B%81%5B%83h/?category=0001"
        case .ssd:
            return "https://kakaku.com/search_results/SSD/?category=0001"
        case .hdd:
            return "https://kakaku.com/search_results/hdd/?category=0001"
        case .pcCase:
            return "https://kakaku.com/search_results/pc%83P%81%5B%83X/?category=0001"
        case .powerUnit:
            return "https://kakaku.com/search_results/%93d%8C%B9%83%86%83j%83b%83g/?category=0001"
        case .caseFan:
            return "https://kakaku.com/search_results/%83P%81%5B%83X%83t%83%40%83%93/?category=0001"
        case .monitor:
            return "https://kakaku.com/search_results/%83%82%83j%83%5E%81%5B/?category=0001"
        }
    }
    
    func specItems() -> [String] {
        switch self {
        case .cpu:
            return ["スペック", "プロセッサ名", "世代", "ソケット形状", "コア数", "TDP", "クロック周波数", "最大動作クロック周波数", "スレッド数", "マルチスレッド", "三次キャッシュ", "二次キャッシュ", "グラフィックス"]
        case .cpuCooler:
            return ["対応ソケット","Intel対応ソケット", "AMD対応ソケット" ,"本体スペック" ,"タイプ" , "ファンサイズ", "ラジエーターサイズ", "最大ファン風量", "最大ファン回転数", "ノイズレベル", "ロープロファイル対応", "LEDライティング対応", "PWM", "コネクタ", "ファン寿命", "干渉軽減", "デュアルファン", "TDP", "材質", "幅x高さx奥行"]
        case .memory:
            return ["スペック", "メモリ容量(1枚あたり)", "枚数", "メモリインターフェイス", "メモリ規格", "データ転送速度", "モジュール規格", "電圧", "メモリタイミング", "メモリ機能", "XMP 2.0", "ヒートシンク機能", "Mac対応", "1GBあたりの価格"]
        case .motherBoard:
            return ["基本スペック", "チップセット", "CPUソケット", "フォームファクタ", "マルチCPU", "詳細メモリタイプ", "メモリスロット数", "最大メモリー容量", "幅x奥行き", "拡張スロット","PCIスロット", "PCI-Express 16X", "PCI-Express 8X", "PCI-Express 4X", "PCI-Express 1X", "VGAスロット", "ストレージ", "SATA", "Serial ATA", "M.2ソケット数", "M.2サイズ","グラフィック・オーディオ" ,"DisplayPort数", "Mini DisplayPort数", "HDMIポート数", "S/PDIF", "USB", "その他機能","SLI", "CrossFire", "CrossFire", "VRMフェーズ数", "一体型 I/O バックパネル", "LED制御機能", "ネットワーク","無線LAN", "Bluetooth", "LAN", "オンボード機能","オンボードLAN", "オンボードRAID", "オンボードオーディオ", "オンボードグラフィック"]
        case .graphicsCard:
            return ["基本スペック","搭載チップ", "メモリバス", "CUDAコア数", "SP数", "メモリクロック", "メモリ", "バスインターフェイス", "解像度", "モニタ端子", "冷却タイプ", "ファンレス", "セミファンレス", "最大ディスプレイ接続台数", "消費電力", "その他機能","ロープロファイル対応", "4K対応", "補助電源", "SLI", "CrossFire", "LED制御機能", "DirectX", "OpenGL", "サイズ","本体(幅x高さx奥行)", "ラジエータ(幅x高さx奥行)"]
        case .ssd:
            return ["スペック","容量", "規格サイズ", "インターフェイス", "タイプ", "設置タイプ", "NVMe", "厚さ", "1GBあたりの価格", "読込速度", "パフォーマンス","書込速度", "ランダム読込速度", "ランダム書込速度", "耐久性","MTBF(平均故障間隔)", "TBW", "DWPD"]
        case .hdd:
            return ["スペック","容量", "回転数", "書き込み方式", "インターフェイス", "キャッシュ", "消費電力", "ハイブリッドHDD (SSHD)", "平均シークタイム", "フラッシュメモリタイプ", "フラッシュメモリ容量", "ディスク枚数", "1TBあたりの価格"]
        case .pcCase:
            return ["基本スペック","電源規格", "拡張スロット", "ドライブベイ", "サイドパネル", "前面インターフェイス", "ロープロファイル", "ファンコントローラー", "対応サイズ","対応マザーボード", "対応グラフィックボード", "対応CPUクーラー", "対応電源ユニット", "搭載可能ファン","上面・上部(トップ)", "前面(フロント)", "背面・後部(リア)", "側面(サイド)", "底面(ボトム)", "その他", "搭載可能ラジエータ", "付属ファン", "サイズ・重量", "重量", "幅x高さx奥行", "容積", "カラー"]
        case .powerUnit:
            return ["基本スペック", "対応規格", "電源容量", "80PLUS認証", "プラグイン対応", "Haswell対応", "1Wあたりの価格", "コネクタ", "メインコネクタ", "CPU用コネクタ", "PCI Expressコネクタ", "SATA", "ペリフェラル", "FDD", "サイズ・重量", "サイズ", "重量"]
        case .caseFan:
            return ["スペック", "ファンサイズ", "最大風量", "最大ノイズレベル", "最大回転数", "PWM", "コネクタ", "LEDライティング対応", "ファンコン", "ファンブレード取り外し可", "耐久性", "個数", "幅x高さx厚さ"]
        case .monitor:
            return ["基本スペック", "モニタサイズ", "モニタタイプ", "モニタ形状", "画面種類", "スリムベゼル", "アスペクト比", "表面処理", "パネル種類", "解像度", "HDR方式", "DisplayHDR", "表示色", "表示領域", "色域", "応答速度", "コントラスト比", "拡張コントラスト比", "輝度", "視野角（上下/左右）", "画素ピッチ", "水平走査周波数", "リフレッシュレート(垂直走査周波数)", "最大消費電力", "LEDバックライト", "フリッカーフリー", "1型(インチ)あたりの価格", "詳細機能", "入力端子", "スピーカー搭載", "音声出力端子", "USB HUB", "HDCP2.2", "HDCP", "リモコン", "カラーマネジメント機能", "PIP", "PBP", "VESAマウント", "MHL対応", "ゲーミングモニター", "モバイルディスプレイ", "USB PD", "メディアプレーヤ機能", "3D対応", "ブルーライト軽減", "調整機能","ピボット機能(画面回転)", "スイーベル機能(水平回転)", "チルト機能(垂直角度調節)", "高さ調節機能", "同期技術", "G-SYNC", "FreeSync", "Adaptive-Sync", "タッチパネル", "タッチパネル方式", "タッチパネル対応", "マルチタッチ", "タッチペン付属", "サイズ・重量", "幅x高さx奥行き", "重量"]
        }
    }
}

class PcParts {
    
    let category: Category
    let maker: String
    let title: String
    let price: String
    let image: URL
    let detailUrl: String
    
    init(category: Category, maker: String, title:String, price:String, image:URL, detail:String) {
        self.category = category
        self.maker = maker
        self.title = title
        self.price = price
        self.image = image
        self.detailUrl = detail
    }
    
    func getPriceInt() -> Int{
        let exceptMark = self.price.replacingOccurrences(of: "¥", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: " ～", with: "")
        if let intPrice = Int(exceptMark){
            return intPrice
        }
        return 0
    }
    var specs = [String:String]()
    
    // PcParts.categoryをCoredataで保存できなかったため、category.rawValueだけ保存して
    // CoreDataから取り出した際にrawValueからcategoryを返す
    private static func restoreFromRawValue(value: String) -> Category {
        switch (value) {
        case "CPU":
            return .cpu
        case "CPUクーラー":
            return .cpuCooler
        case "メモリー":
            return .memory
        case "マザーボード":
            return .motherBoard
        case "グラフィックボード・ビデオカード":
            return .graphicsCard
        case "SSD":
            return .ssd
        case "ハードディスク・HDD":
            return .hdd
        case "PCケース":
            return .pcCase
        case "電源ユニット":
            return .powerUnit
        case "ケースファン":
            return .caseFan
        case "PCモニター・液晶ディスプレイ":
            return .monitor
        default:
            return .cpu
        }
    }
    
    static func toPcPartsFromPartsObject(partsObjects: [Parts]) -> [PcParts]{
        var pcparts:[PcParts] = []
        
        for parts in partsObjects {
            let category = PcParts.restoreFromRawValue(value: parts.category!)
            let p = PcParts(category: category, maker: parts.maker!, title: parts.title!, price: parts.price!, image: parts.img!, detail: parts.detail!)
            pcparts.append(p)
        }
        
        return pcparts
    }
    
    static func sortParts(partsList: [PcParts]) -> [PcParts]{
        var cpu :PcParts? = nil
        var cpuCooler :PcParts? = nil
        var memory :PcParts? = nil
        var motherboard :PcParts? = nil
        var graphicsCard :PcParts? = nil
        var ssd :PcParts? = nil
        var hdd :PcParts? = nil
        var pcCase :PcParts? = nil
        var powerUnit :PcParts? = nil
        var caseFan :PcParts? = nil
        var monitor :PcParts? = nil
        
        for parts in partsList {
            switch (parts.category) {
            case .cpu:
                cpu = parts
            case .cpuCooler:
                cpuCooler = parts
            case .memory:
                memory = parts
            case .motherBoard:
                motherboard = parts
            case .graphicsCard:
                graphicsCard = parts
            case .ssd:
                ssd = parts
            case .hdd:
                hdd = parts
            case .pcCase:
                pcCase = parts
            case .powerUnit:
                powerUnit = parts
            case .caseFan:
                caseFan = parts
            case .monitor:
                monitor = parts
            }
        }
        // NewCustomViewControllerと同じ順番に並べる
        let sortedPartsList:[PcParts?] = [cpu, cpuCooler, memory, motherboard, graphicsCard, ssd, hdd, pcCase, powerUnit, caseFan, monitor]
        return sortedPartsList.compactMap{$0}
    }
}

enum Tipset : String {
    case Z690 = "Z690"
    case H670 = "H670"
    case B660 = "B660"
    case H610 = "H610"
    case Z590 = "Z590"
    case H570 = "H570"
    case H510 = "H510"
    
    func compatibleCPU(_ tipset:Tipset) -> [String] {
        switch (tipset) {
        case .Z690, .H670, .B660:
            return ["i9-12900KS", "i9-12900T", "i9-12900F", "i9-12900", "i9-12900KF", "i9-12900K", "i7-12700T", "i7-12700F", "i7-12700", "i7-12700KF", "i7-12700K", "i5-12600T", " i5-12600", "i5-12500", " i5-12500T", "i5-12400T", "i5-12400F", "i5-12400", "i5-12600KF", "i5-12600K", "i3-12100", "i3-12100T", "i3-12300T", "i3-12300", "i3-12100F"]
        case .H610:
            return ["i9-12900KS", "i9-12900T", "i9-12900E", "i9-12900TE","i9-12900F", "i9-12900", "i9-12900KF", "i9-12900K", "i7-12700T", "i7-12700TE", "i7-12700E","i7-12700F", "i7-12700", "i7-12700KF", "i7-12700K", "i5-12600T", " i5-12600", "i5-12500", " i5-12500T", "i5-12400T", "i5-12400F", "i5-12400", "i5-12600KF", "i5-12600K", "i5-12500TE", "i5-12500E", "i3-12100", "i3-12100T", "i3-12300T", "i3-12300", "i3-12100F", "i3-12100TE", "i3-12100E"]
        case .Z590:
            return ["i9-11900", "i9-11900F", "i9-11900T", "i9-11900KF", "i9-11900K", "i9-10850K", "i9-10900TE", "i9-10900KF", "i9-10900F", "i9-10900", "i9-10900T", "i9-10900E", "i9-10900K", "i7-11700T", "i7-11700K", "i7-11700KF", "i7-11700", "i7-11700F", "i7-10700TE", "i7-10700E", "i7-10700K", "i7-10700KF", "i7-10700F", "i7-10700", "i7-10700T", "i5-11400", "i5-11400F", "i5-11500T", "i5-11400T", "i5-11500", "i5-10505", "i5-10600T", "i5-10400F", "i5-10500", "i5-10400T", "i5-10500T", "i5-10600", "i5-10600KF", "i5-10400", "i5-10600K", "i5-10500TE", "i5-10500E", "i3-10325", "i3-10105T", "i3-10305", "i3-10305T", "i3-10105F", "i3-10105", "i3-10100F","i3-10100", "i3-10100T", "i3-10300T", "i3-10300", "i3-10320"]
        case .H570:
            return ["i9-11900", "i9-11900F", "i9-11900T", "i9-11900KF", "i9-11900K", "i7-11700T", "i7-11700K", "i7-11700KF", "i7-11700", "i7-11700F", "i5-11400", "i5-11400F", "i5-11500T", "i5-11400T", "i5-11500", "i5-10505", "i5-10400F", "i5-10500", "i5-10400T", "i5-10500T", "i5-10400", "i5-10500TE", "i5-10500E", "i3-10325", "i3-10105T", "i3-10305", "i3-10305T", "i3-10105F", "i3-10105", "i3-10100F", "i3-10100", "i3-10100T", "i3-10300T", "i3-10300", "i3-10320"]
        case .H510:
            return ["i9-11900", "i9-11900F", "i9-11900T", "i9-11900KF", "i9-11900K", "i7-11700T", "i7-11700K", "i7-11700KF", "i7-11700", "i7-11700F", "i5-11400", "i5-11400F", "i5-11500T", "i5-11400T", "i5-11500", "i5-10505", "i5-10400F", "i5-10500", "i5-10400T", "i5-10500T", "i5-10400", "i5-10500TE", "i5-10500E", "i5-10600", "i5-10600T", "i5-10600K", "i5-10600KF","i3-10325", "i3-10105T", "i3-10305", "i3-10305T", "i3-10105F", "i3-10105", "i3-10100F", "i3-10100", "i3-10100T", "i3-10300T", "i3-10300", "i3-10320"]
        }
    }
}
