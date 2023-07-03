//
//  PostRequestPage.swift
//  4month.1,2hw
//
//  Created by meerim on 02.07.2023.
//

import UIKit

class PostRequestPage: UIViewController {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Add New Product"
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var idTextField: UITextField = {
       let view = UITextField()
        view.placeholder = "Input id"
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
        view.leftViewMode = .always
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Name"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
         view.placeholder = "Input product name"
         view.layer.borderWidth = 1
         view.layer.cornerRadius = 16
         view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
         view.leftViewMode = .always
         return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var priceTextField: UITextField = {
        let view = UITextField()
         view.placeholder = "Input price"
         view.layer.borderWidth = 1
         view.layer.cornerRadius = 16
         view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
         view.leftViewMode = .always
         return view
    }()
        
    private lazy var postBtn: UIButton = {
       let button = UIButton()
        button.setTitle("POST", for: .normal)
        button.addTarget(self, action: #selector(postRequest), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpView()
        
        
    }
    
    private func setUpView(){
        
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(40)
        }
        
        view.addSubview(idTextField)
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
        }
        
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
        }
        
        view.addSubview(priceTextField)
        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        
        view.addSubview(postBtn)
        postBtn.snp.makeConstraints { make in
            make.top.equalTo(priceTextField.snp.bottom).offset(100)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
    
    }
    
    @objc private func postRequest(){
        if idTextField.text != "" && titleTextField.text != "" && priceTextField.text != ""{
            ApiManager.shared.requestPostData(id: Int(idTextField.text ?? "") ?? 0,
                                              title: titleTextField.text ?? "",
                                              price: Int(idTextField.text ?? "") ?? 0) { result in
                switch result {
                case .success(let statusCode):
                    DispatchQueue.main.async {
                        self.showAllert(with: "Status Code", message: "Request Code - \(statusCode) ")
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }else{
            showAllert(with: "Error", message: "Заполните все поля!")
        }
    }
    
    private func showAllert(with title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
