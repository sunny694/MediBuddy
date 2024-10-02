//
//  MBLaunchVC.swift
//  MediBuddy
//
//  Created by Sunny Jha on 28/09/24.
//

import UIKit

class MBLaunchVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: add animations or video -- By passed for now
        // Do any additional setup after loading the view.
        let vc = MBLoginVC(nibName: "MBLoginVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: false)
        // add launch animation if required and then prooceed
    }

}

