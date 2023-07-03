//
//  SecondViewController.swift
//  4month.1,2hw
//
//  Created by meerim on 28.06.2023.
//

import Foundation

import UIKit
import Kingfisher

class SecondViewController: UIViewController {
    
    var product: Product?
    
    lazy var productImage: UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .systemGreen
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
        
        setUpViews()
        
        let url = URL(string: (product?.thumbnail)!)
        productImage.kf.setImage(with: url)
        
        nameLabel.text = product?.title
        descriptionLabel.text = product?.description
        priceLabel.text = String(product?.price ?? 0) + "$"
        
    }
    
    private func setUpViews(){
        
        view.addSubview(productImage)
        
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(300)
        }
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        
        view.addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
    }
    
}
