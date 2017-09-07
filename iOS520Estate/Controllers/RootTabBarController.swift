//
//  RootTabBarController.swift
//  iOS520Estate
//
//  Created by Yonglun Liu on 2017/9/6.
//  Copyright © 2017年 YonglunTech. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.childViewControllers[0].tabBarItem=UITabBarItem(title: nil, image: UIImage(named: "home_e@2x.png")?.withRenderingMode(UIImageRenderingMode.automatic), selectedImage: UIImage(named: "home@2x.png"))
        self.childViewControllers[1].tabBarItem=UITabBarItem(title: nil, image: UIImage(named: "complex_e@2x.png")?.withRenderingMode(UIImageRenderingMode.automatic), selectedImage: UIImage(named: "complex@2x.png"))
        self.childViewControllers[2].tabBarItem=UITabBarItem(title: nil, image: UIImage(named: "profile_e@2x.png")?.withRenderingMode(UIImageRenderingMode.automatic), selectedImage: UIImage(named: "profile@2x.png"))
        for i in self.childViewControllers {
            i.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
        
        //self.view.window?.tintColor = globalTintColor
        // Do any additional setup after loading the view.
        self.view.backgroundColor=globalBackgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
