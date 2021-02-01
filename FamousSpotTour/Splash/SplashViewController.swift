//
//  SplashViewController.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/28.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {

    let splash: UIImageView = {
        let img = UIImageView(image: UIImage(named: "Splash Image"))
        img.contentMode = .scaleAspectFill
        return img
    }()

    let loading: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.color = UIColor(hex: "#3EC6FF")
        return indicator
    }()
    
    let stack = VerticalStackView(arrangedSubviews: [], spacing: 10, alignment: .center, distribution: .equalCentering)

    let nextViewController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: TopViewController())
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }()

    let useCase: UseCaseDelegate = SplashUseCase()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSplashImage()
        self.beginFetch()
        self.useCase.run(completeion: {() in
            self.goNext()
        })
    }
    
    private func goNext() {
        super.present(self.nextViewController,  animated: true, completion: nil)
    }

    private func setSplashImage() {
        super.view.addSubview(self.splash)
        self.splash.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(super.view.bounds.height * 0.25)
            make.center.equalTo(super.view)
        }
    }

    private func beginFetch() {
        super.view.addSubview(self.loading)
        self.loading.center = super.view.center
        self.loading.startAnimating()
    }
    
}
