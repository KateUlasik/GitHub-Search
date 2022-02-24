//
//  ViewController.swift
//  GitHub Search
//
//  Created by Katharina Ulasik on 08.02.2022.
//

import UIKit

class ViewController: UIViewController {
    private static let TOKEN_ID = "saved_git_token"
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var debugPanelHeight: NSLayoutConstraint!
    @IBOutlet weak var showPanelButton: UIButton!
    @IBOutlet weak var tokenTextField: UITextField!
    
    private var items: [GitResponseItems] = []
    private var token: String?
    private let storageService = StorageService()
    private let networkService = NetworkService()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
          collectionView.collectionViewLayout = collectionViewFlowLayout
          collectionViewFlowLayout.minimumLineSpacing = 50
          
          collectionView.layer.cornerRadius = 0
          collectionView.layer.borderWidth = 1
          
        collectionView.dataSource = self
        collectionView.delegate = self

          collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 160)
          
          collectionView.collectionViewLayout = collectionViewFlowLayout
          
        collectionView.register(UINib(nibName: "GitItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GitItemCollectionViewCell")
        
        self.showPanelButton.setTitle("Hide debug panel", for: .normal)
        
        self.token = storageService.getToken()
        self.tokenTextField.text = self.token
        
//        Hide panel
        hideDebugPanel()
    }
    
    @IBAction func touchDownTokenTextField(_ sender: Any) {
        showTokenViewController()
    }
    
    
    @IBAction func showDebugAction(_ sender: Any) {
        if self.outputTextView.isHidden {
            showDebugPanel(animated: true)
        } else {
                hideDebugPanel(animated: true)
        }
    }
    
    private func hideDebugPanel(animated: Bool = false) {
        let duratiom: TimeInterval = animated ? 1 : 0
        
        UIView.animate(withDuration: duratiom) {
            self.debugPanelHeight.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.outputTextView.isHidden = true
            self.showPanelButton.setTitle("Show debug panel", for: .normal)
    }
    }
    
    private func showDebugPanel(animated: Bool) {
        let duration: TimeInterval = animated ? 1 : 0
        
        self.outputTextView.isHidden = false
        
        UIView.animate(withDuration: duration) {
            self.debugPanelHeight.constant = 230
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.showPanelButton.setTitle("Hide debug panel", for: .normal)
    }
    }
    
    @IBAction func makeRequestAction(_ sender: Any) {
        self.outputTextView.text = "Loading..."
        
        if token == nil {
            showTokenViewController()
        } else {
        if let searchText = inputTextField.text, searchText.isEmpty == false {
            let token = self.tokenTextField.text ?? ""
            let header = ["Authorization" : "token \(token)"]
            self.networkService.getSearch(searchText: searchText, header: header)
//            makeRequest(searchText: searchText) { (rawtext, response) in
//                if response == nil {
//                    self.showTokenViewController()
//                } else {
//                self.outputTextView.text = rawtext
//                self.items = (response?.items ?? [])
//
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//                }
//            }
            } else {
            outputTextView.text = "Error: Search text is nil..."
        }
    }
   
    }
//   MARK: - Private section
    
    private func showTokenViewController() {
        let vc = TokenViewController(nibName: "TokenViewController", bundle: nil)
           
           vc.fireAfterClose = {
            self.token = self.storageService.getToken()
            self.tokenTextField.text = self.token

           }
               
           self.present(vc, animated: true, completion: nil)
    }
    
    private func loadToken() -> String? {
        guard let token = UserDefaults.standard.value(forKey: Self.TOKEN_ID) as? String else { return nil }
        return token
    }
    
    private func saveToken(token: String?) {
        UserDefaults.standard.set(token, forKey: Self.TOKEN_ID)
    }
    
//    private func makeRequest(searchText: String, completion: @escaping (_ rawText: String?, _ response: GitResponse?) -> ()) {
//        let url = URL(string: "https://api.github.com/search/code?q='\(searchText)'")!
//
//        var request = URLRequest(url: url)
//
//        let token = self.tokenTextField.text ?? ""
//
//        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
//
//        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if error == nil, let data = data {
//                DispatchQueue.main.async {
//                    do {
//                        let jsonDecoder = JSONDecoder()
//                        let objectFromJson = try jsonDecoder.decode(GitResponse.self, from: data)
//
//                        let txt = String(data: data, encoding: .utf8)
//                        completion(txt, objectFromJson)
//                    } catch {
//                        completion("ERROR: Parse error", nil)
//                    }
//                }
//            } else {
//                DispatchQueue.main.async {
//                    completion("ERROR!", nil)
//                }
//            }
//        }.resume()
//    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GitItemCollectionViewCell", for: indexPath) as! GitItemCollectionViewCell
    
        let item = items[indexPath.row]
        cell.configure(item: item)
        
        return cell
    }
    
}
