//
//  ViewController.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/14.
//

import UIKit

class ViewController: UIViewController {

  let spotsRepository: SpotsRepository = SpotsRepository()

  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.backgroundColor = .white

    self.spotsRepository.all { (items) in
      for item in items {
        print(item.data())
      }
    }

    self.spotsRepository.find(by: "id_1") { (data) in
      print(data)
    }
  }


}

