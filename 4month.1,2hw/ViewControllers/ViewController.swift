//
//  ViewController.swift
//  4month.1,2hw
//
//  Created by meerim on 28.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var catalogData: [Product] = []
    
    private lazy var catalogTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        navigationItem.title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(openAddVC))
        
        netWorking()
        tableViewSetting()
        setUpView()
        
    }
    
    private func netWorking(){
        
        ApiManager.shared.requestData { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.catalogData = value.products ?? []
                    self.catalogTableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    func tableViewSetting(){
        catalogTableView.dataSource = self
        catalogTableView.delegate = self
        catalogTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setUpView() {
        
        view.addSubview(catalogTableView)
        
        catalogTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalogData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let model = catalogData[indexPath.row]

        cell.setData(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondViewController()
        
        vc.product = catalogData[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openAddVC(){
        navigationController?.pushViewController(PostRequestPage(), animated: true)
    }
    
}

