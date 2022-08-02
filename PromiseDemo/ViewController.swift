//
//  ViewController.swift
//  PromiseDemo
//
//  Created by eslam mohamed on 02/08/2022.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {
    
    let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        
    }
    
    func getData(){
        
        firstly {
            network.fetchDataFromApi(urlString: URLs.traffic(), baseModel: TrafficBase.self)
        }.done { trafficBase in
            print(trafficBase)
        }.ensure {
            //something will alawys happen
        }.catch { err in
            print(err)
        }
        
        
    }


}

