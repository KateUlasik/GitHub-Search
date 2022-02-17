//
//  ViewController.swift
//  GitHub Search
//
//  Created by Katharina Ulasik on 08.02.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var debugPanelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var showPanelButton: UIButton!
    
    @IBOutlet weak var tokenTextField: UITextField!
    
    private var items: [GitResponseItems] = []
        
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
    }
    
    
    
    @IBAction func showDebugAction(_ sender: Any) {
        if self.outputTextView.isHidden {
            self.outputTextView.isHidden = false
            
            UIView.animate(withDuration: 1) {
                self.debugPanelHeight.constant = 230
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.showPanelButton.setTitle("Hide debug panel", for: .normal)
        }
            } else {
                UIView.animate(withDuration: 1) {
                    self.debugPanelHeight.constant = 0
                    self.view.layoutIfNeeded()
                } completion: { _ in
                    self.outputTextView.isHidden = true
                    self.showPanelButton.setTitle("Show debug panel", for: .normal)
            }
        }
    }
    
    @IBAction func makeRequestAction(_ sender: Any) {
        self.outputTextView.text = "Loading..."
        
        if let searchText = inputTextField.text, searchText.isEmpty == false {
            makeRequest(searchText: searchText) { (rawtext, response) in
                self.outputTextView.text = rawtext
                self.items = (response?.items ?? [])
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                }
            } else {
            outputTextView.text = "Error: Search text is nil..."
        }
    }
   
    private func makeRequest(searchText: String, completion: @escaping (_ rawText: String?, _ response: GitResponse?) -> ()) {
        let url = URL(string: "https://api.github.com/search/code?q='\(searchText)'")!
        
        var request = URLRequest(url: url)
        
        let token = self.tokenTextField.text ?? ""
        
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                DispatchQueue.main.async {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let objectFromJson = try jsonDecoder.decode(GitResponse.self, from: data)
                                                                    
                        let txt = String(data: data, encoding: .utf8)
                        completion(txt, objectFromJson)
                    } catch {
                        completion("ERROR: Parse error", nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion("ERROR!", nil)
                }
            }
        }.resume()
    }
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
