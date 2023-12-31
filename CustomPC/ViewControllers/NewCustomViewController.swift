import UIKit
import SVProgressHUD

class NewCustomViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    var selectedParts:[PcParts] = []
    @IBOutlet weak var selectTable: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var compatibilityLabel: UILabel!
    @IBOutlet weak var keepButton: UIButton!
    @IBOutlet weak var selectTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var compatibilityDetailButton: UIButton!
    var cancelButton: UIBarButtonItem!
    var compatibilityMsg:String?
    var storedCustom : Custom? = nil
    private var parts = [Category.cpu, Category.cpuCooler, Category.memory, Category.motherBoard, Category.graphicsCard, Category.ssd, Category.hdd, Category.pcCase, Category.powerUnit, Category.caseFan, Category.monitor]
    
    override func viewDidLoad() {
        self.title = "Combination"
        super.viewDidLoad()
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel(_:)))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        compatibilityLabel.textColor = .white
        if let message = compatibilityMsg {
            
            if message == "選択されたパーツの互換性に問題ありません" {
                compatibilityLabel.text = message
                compatibilityLabel.backgroundColor = .systemGreen
                compatibilityDetailButton.isEnabled = false
                
            } else {
                compatibilityLabel.text = "選択されたパーツの互換性に問題があります\n" + message
                compatibilityLabel.backgroundColor = .systemRed
                compatibilityDetailButton.isEnabled = true
            }
        } else {
            let msg = "選択されたパーツの互換性に問題ありません"
            self.compatibilityMsg = msg
            compatibilityLabel.text = msg
            compatibilityLabel.backgroundColor = .systemGreen
            compatibilityDetailButton.isEnabled = false
        }
        keepButton.backgroundColor = UIColor.systemBlue
        keepButton.layer.cornerRadius = 10
        
        let unselectedNib = UINib(nibName: UnstoredCategoryCell.cellIdentifier, bundle: nil)
        let selectedNib = UINib(nibName: SearchPartsTableViewCell.cellIdentifier, bundle: nil)
        selectTable.register(selectedNib, forCellReuseIdentifier: SearchPartsTableViewCell.cellIdentifier)
        selectTable.register(unselectedNib, forCellReuseIdentifier: UnstoredCategoryCell.cellIdentifier)
        selectTable.rowHeight = UITableView.automaticDimension
        
        let mainBoundSize = UIScreen.main.bounds.size.height
        self.view.layoutIfNeeded()
        if mainBoundSize < 812 {
            self.selectTableViewHeight.constant = CGFloat(450)
        }
        
        compatibilityDetailButton.setTitle("", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var totalPrice = 0
        
        for parts in self.selectedParts{
            totalPrice += parts.getPriceInt()
        }
        
        let yen = "¥" + String.localizedStringWithFormat("%d", totalPrice)
        DispatchQueue.main.async {
            self.priceLabel.text = yen
            self.selectTable.reloadData()
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        let alert = UIAlertController(title: "見積もりキャンセル", message: "選択したパーツは保存されません", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        let cancel = UIAlertAction(title: "戻る", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showCompatibilityMessage(_ sender: Any) {
        
    }
    
    @IBAction func didTapKeepButton(_ sender: Any) {
        
        if (selectedParts.count == 0) {
            let alert = UIAlertController(title: "パーツを選択してください", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel) { (acrion) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        var alertTextField:UITextField!
        alert.title = "見積もりタイトル"
        alert.addTextField(configurationHandler: {(textField) -> Void in
            textField.delegate = self
            alertTextField = textField
            if let custom = self.storedCustom {
                textField.placeholder = custom.title!
            }
        })
        
        alert.addAction(
            UIAlertAction(
                title: "追加",
                style: .default,
                handler: {(action) -> Void in
                    // 未入力で追加ボタンが押された場合
                    if (alertTextField.text! == "" && self.storedCustom != nil) {
                        alertTextField.text! = self.storedCustom?.title! ?? ""
                    }else if (alertTextField.text! == ""){
                        alertTextField.text! = "タイトルなし"
                    }
                    
                    AccessData.storeCustom(title: alertTextField.text!, price: self.priceLabel.text!, message: self.compatibilityMsg!, parts: self.selectedParts)
                    if let custom = self.storedCustom {
                        AccessData.deleteCustom(custom: custom)
                    }
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                })
        )
        
        //キャンセルボタン
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel
            )
        )
        
        //アラートが表示されるごとにprint
        self.present(
            alert,
            animated: true
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let partsCategory = parts[indexPath.row].rawValue
        var isSelected = false
        var selectedParts:PcParts?
        
        for parts in self.selectedParts {
            if parts.category.rawValue == partsCategory {
                isSelected = true
                selectedParts = parts
            }
        }
        
        if isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchPartsTableViewCell.cellIdentifier, for: indexPath) as! SearchPartsTableViewCell
            cell.setup(parts: selectedParts!)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: UnstoredCategoryCell.cellIdentifier, for: indexPath) as! UnstoredCategoryCell
            cell.setup(category: parts[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SVProgressHUD.show()
        let selected = parts[indexPath.row]
        SearchParts.searchParts(selectedCategory: selected, searchURL: selected.startPageUrl()) { parts in
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "SearchPartsViewController", bundle: nil)
                let nextVC = storyboard.instantiateViewController(identifier: "SearchPartsViewController")as! SearchPartsViewController
                nextVC.pcPartsSeq = parts
                nextVC.selectedCategory = selected
                nextVC.selectedParts = self.selectedParts
                if let custom = self.storedCustom {
                    nextVC.storedCustom = custom
                }
                tableView.deselectRow(at: indexPath, animated: true)
                SVProgressHUD.dismiss()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
