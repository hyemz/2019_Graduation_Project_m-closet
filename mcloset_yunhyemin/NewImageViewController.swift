//
//  NewImageViewController.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 19/06/2019.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import UIKit

class NewImageViewController: UIViewController {

    @IBOutlet weak var IBimgNewCroppedImage: UIImageView!
    
    var newImageFile:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IBimgNewCroppedImage.image = newImageFile
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
