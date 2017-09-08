//
//  HomeCarouselViewController.swift
//  iOS520Estate
//
//  Created by Yonglun Liu on 2017/9/6.
//  Copyright © 2017年 YonglunTech. All rights reserved.
//

import UIKit
import CoreData
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

//let CarouselImageSet = ["room_1.jpg","room_2.jpg","room_3.jpg","room_4.jpg","room_5.jpg","room_6.jpg","room_7.jpg"]
let CarouselImageSet = ["1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png"]

class HomeCarouselViewController: UIPageViewController,UIPageViewControllerDataSource{
    
    var source:HomeTableViewController!
    var imageIndexCurrent = 0
    var imageIndexLast=CarouselImageSet.count-1
    var imageIndexNext = 1
    var currentViewController:CarouselPageController=CarouselPageController()
    
    
    let typeSet = [1,2,3]
    var list:[carouselInfo]=[]
    //private var timer: Timer = Timer()
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource=self
        //self.view.frame.size.height = screenWidth / 375.0 * 183.0
        //print("------adjusted height:\(self.view.frame.size.height)")
        //print(screenSize)
        //let contentVC=CarouselPageController()
        
        
        self.currentViewController.imageName=CarouselImageSet[imageIndexCurrent]
        self.currentViewController.Index=imageIndexCurrent
        let contents = [self.currentViewController]
        self.setViewControllers(contents, direction: .forward, animated: false, completion: nil)

        
        self.view.backgroundColor=UIColor.black
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.advancePage), userInfo: nil, repeats: true)
        
        
        
        
        //        let testimg = UIImageView()
        //        testimg.image=UIImage(named: "Car0.png")
        //
        //        self.view.addSubview(testimg)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentViewController.imageView.backgroundColor = globalLoadingColor
        
        //        if DataFromServer.carouselIsNil! {
        //            //currentViewController.imageName = CarouselImageSet.first
        //            //currentViewController.imageView.tag = 1
        //            currentViewController.imageView.backgroundColor = globalLoadingColor
        //            currentViewController.imageView.tag=404
        //        }else{
        //
        //            //need to fix thread not safe here
        //            if let cell = DataFromServer.carouselInfo?[0] as? [String:AnyObject]{
        //                print(cell)
        //                currentViewController.imageUrl = cell["imgAddr"] as? String
        //                currentViewController.contentID = cell["contentID"] as? Int
        //                //print(cell["imgAddr"])
        //                currentViewController.imageView.tag = cell["style"] as! Int
        //            }
        //
        //        }
//        let url = URL(string: DataFromServer.homeCarouselUrl)
//        print(currentuser)
//        print(url ?? "url error")
//        
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard error == nil else {
//                print(error!)
//                return
//            }
//            guard let data = data else {
//                print("Data is empty")
//                return
//            }
//            print(data)
//            
//            
//            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [Any]{
//                for item in json{
//                    let obj = item as![String:Any]
//                    let c = carouselInfo()
//                    c.cover=obj["imgAddr"] as? String
//                    c.ID=obj["contentID"] as? Int
//                    c.type=obj["style"] as? Int
//                    self.list.append(c)
//                }
//                let image = fetchImage(url: (self.list.first?.cover)!, context: g_context)
//                DispatchQueue.main.async {
//                    self.currentViewController.imageView.image=image
//                    self.currentViewController.contentID=self.list.first?.ID
//                    self.currentViewController.type=self.list.first?.type
//                    self.currentViewController.Index = 0
//                    firstCarouselPageController = self.currentViewController
//                    let contents = [self.currentViewController]
//                    self.setViewControllers(contents, direction: .forward, animated: false, completion: nil)
//                }
//                
//            }else{
//                print("[Failed]Did not get user data from server when trying to downloading the user data")
//            }
//            
//        }
//        task.resume()
        
    }
    
    
    func advancePage () {
        //let pvcs = self.childViewControllers as! [CarouselPageController]
        
        let itemIndex = imageIndexCurrent
        
        
        let firstController = getItemController(itemIndex: itemIndex+1)!
        let startingViewControllers = [firstController]
        self.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion:nil)
    }
    
    
    private func getItemController(itemIndex: Int) -> CarouselPageController? {
        print(itemIndex)
        if itemIndex < CarouselImageSet.count {
            let pageItemController = CarouselPageController()
            pageItemController.Index = itemIndex
            pageItemController.imageName = CarouselImageSet[itemIndex]
            imageIndexCurrent+=1
            return pageItemController
        }else{
            let pageItemController = CarouselPageController()
            pageItemController.Index=0
            pageItemController.imageName=CarouselImageSet[0]
            imageIndexCurrent=0
            return pageItemController
        }
        
    }
    

    
    func scrollToNext()  {
        //        let currentView=self.
        //        let currentName = (viewController as! CarouselPageController).imageName
        //        let currentIndex = imageSet.index(of: currentName!)
        //        let contentVC=CarouselPageController()
        //        if currentIndex<imageSet.count-1 {
        //            contentVC.imageName = imageSet[currentIndex+1]
        //            contentVC.Index=currentIndex+1
        //            let contents = [contentVC]
        //
        //            setViewControllers(contents, direction: .forward, animated: true, completion: nil)
        //            imageIndex+=1
        //        }else{
        //            contentVC.imageName = imageSet.first
        //            contentVC.Index=0
        //            let contents = [contentVC]
        //
        //            setViewControllers(contents, direction: .forward, animated: true, completion: nil)
        //            imageIndex=0
        //
        //        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //let currentName = (viewController as! CarouselPageController).imageName
        if let a = viewController as? CarouselPageController{
            
            
            
            let currentIndex = a.Index
            imageIndexCurrent=currentIndex!
            //print(currentIndex)
            if currentIndex<CarouselImageSet.count-1 {
                let nextPage = CarouselPageController()
//                let carousel = list[currentIndex!+1]
//                nextPage.Index = currentIndex!+1
//                nextPage.contentID=carousel.ID
//                nextPage.imageUrl=carousel.cover
//                nextPage.type=carousel.type
                
                
                
                nextPage.Index=currentIndex!+1
                nextPage.imageName=CarouselImageSet[currentIndex!+1]
                imageIndexNext=nextPage.Index
                //imageIndex=currentIndex!+1
                //            if DataFromServer.carouselIsNil! {
                //                //nextPage.imageName=CarouselImageSet[currentIndex!+1]
                //                nextPage.Index=currentIndex!+1
                //                nextPage.imageView.tag=404
                //                nextPage.imageView.backgroundColor=globalLoadingColor
                //            }else{
                //                if let cell = DataFromServer.carouselInfo?[currentIndex!+1] as? [String:AnyObject]{
                //                    nextPage.imageUrl = cell["imgAddr"] as? String
                //                    nextPage.contentID = cell["contentID"] as? Int
                //                    nextPage.imageView.tag = (cell["style"] as? Int)!
                //                }
                //            }
                
                //(viewController as! CarouselPageController).Index = currentIndex!+1
                return nextPage
            }else{
                let firstPage = CarouselPageController()
                firstPage.Index = 0
//                let carousel = list.first ?? carouselInfo()
//                firstPage.Index = 0
//                firstPage.contentID=carousel.ID
//                firstPage.imageUrl=carousel.cover
//                firstPage.type=carousel.type
//                

                firstPage.imageName=CarouselImageSet[0]
                firstPage.Index=0
                //imageIndex=0
                
                //            if DataFromServer.carouselIsNil! {
                //                //firstPage.imageName=CarouselImageSet[0]
                //                firstPage.imageView.tag = 404
                //                firstPage.imageView.backgroundColor=globalLoadingColor
                //                firstPage.Index=0
                //            }else{
                //                if let cell = DataFromServer.carouselInfo?[0] as? [String:AnyObject]{
                //                    print(cell)
                //                    firstPage.imageUrl = cell["imgAddr"] as? String
                //                    firstPage.contentID = cell["contentID"] as? Int
                //                    firstPage.imageView.tag = cell["style"] as! Int
                //                }
                //            }
                //(viewController as! CarouselPageController).Index = 0
                imageIndexNext=firstPage.Index
                return firstPage
            }
        }else{
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        if let a = viewController as? CarouselPageController{
            
            
            
            let currentIndex = a.Index
            imageIndexCurrent=currentIndex!
            //let currentName = (viewController as! CarouselPageController).imageName
            //print(currentIndex)
            if currentIndex > 0 {
                let lastPage = CarouselPageController()
                lastPage.Index = currentIndex!-1
//                let carousel = list[currentIndex!-1]
//                
//                lastPage.Index = currentIndex!-1
//                lastPage.contentID=carousel.ID
//                lastPage.imageUrl=carousel.cover
//                lastPage.type=carousel.type
                
                lastPage.imageName=CarouselImageSet[currentIndex!-1]
                //imageIndex=currentIndex!-1
                
                //            if DataFromServer.carouselIsNil! {
                //                //nextPage.imageName=CarouselImageSet[currentIndex!-1]
                //                //nextPage.imageView.tag=typeSet[currentIndex!-1]
                //                lastPage.imageView.tag=404
                //                lastPage.imageView.backgroundColor=globalLoadingColor
                //
                //            }else{
                //                if let cell = DataFromServer.carouselInfo?[currentIndex!-1] as? [String:AnyObject]{
                //                    lastPage.imageUrl = cell["imgAddr"] as? String
                //                    lastPage.contentID = cell["contentID"] as? Int
                //                    lastPage.imageView.tag = cell["style"] as! Int
                //                }
                //            }
                
                
                
                imageIndexLast=lastPage.Index
                return lastPage
            }else{
                let lastPage = CarouselPageController()
                lastPage.Index = CarouselImageSet.count-1
//                let carousel = list[list.count-1]
//                lastPage.contentID=carousel.ID
//                lastPage.imageUrl=carousel.cover
//                lastPage.type=carousel.type
                lastPage.imageName=CarouselImageSet[CarouselImageSet.count-1]
                //imageIndex=CarouselImageSet.count-1
                //lastPage.Index = 0
                //            if DataFromServer.carouselIsNil! {
                ////                lastPage.Index = CarouselImageSet.count-1
                ////                lastPage.imageName = CarouselImageSet[CarouselImageSet.count-1]
                ////                lastPage.imageView.tag = typeSet[CarouselImageSet.count-1]
                //                lastPage.imageView.backgroundColor=globalLoadingColor
                //                lastPage.imageView.tag=404
                //                lastPage.Index = 0
                //            }else{
                //                if let cell = DataFromServer.carouselInfo?[(DataFromServer.carouselInfo?.count)!-1] as? [String:AnyObject]{
                //                    print(cell)
                //                    lastPage.imageUrl = cell["imgAddr"] as? String
                //                    lastPage.contentID = cell["contentID"] as? Int
                //                    lastPage.imageView.tag = cell["style"] as! Int
                //                    lastPage.Index = (DataFromServer.carouselInfo?.count)!-1
                //                }
                //            }            //(viewController as! CarouselPageController).Index = 0
                
                imageIndexLast=lastPage.Index
                return lastPage
            }
            
        }else{
            return nil
        }
    }
    
    
    
    
    //    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
    //        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: options)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
}
class CarouselPageController :UIViewController{
    
    var Index:Int!
    var imageUrl:String?
    //var context : NSManagedObjectContext? = DataController().managedObjectContext
    
    var type:Int?
    var contentID:Int?
    var imageName:String?{
        didSet{
            imageView.image=UIImage(named: imageName!)
        }
    }
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds=true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (imageUrl != nil) {
            //if let cell = (DataFromServer.carouselInfo?[Index] as? [String:AnyObject]){
            //let addr = cell["imgAddr"]!
            
            DispatchQueue.global().async {
                if let image = fetchImage(url: self.imageUrl!){
                    DispatchQueue.main.async {
                        self.imageView.image=image
                    }
                    
                }
            }
            
            // }
        }
        print("current content id=\(contentID ?? 0)")
        view.addSubview(imageView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.imageTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //saveImagesToCoreData(context: g_context, data: imageData)
    }
    func imageTapped(_ sender:UIGestureRecognizer)  {
//        let parent=self.parent as! HomeCarouselViewController
//        let grandparent=parent.parent as! HomeTableViewController
//        let grandgrandparent = grandparent.parent as!  HomeContainerViewController
//        //let carousel = list[(sender.view?.tag)!]
//        switch self.type! {
//        case 0:
//            grandgrandparent.performSegue(withIdentifier: "homeToVideoDetailSegue", sender: self.contentID)
//        case 1:
//            grandgrandparent.performSegue(withIdentifier: "homeToArticleDetailSegue", sender: self.contentID)
//        case 2:
//            grandgrandparent.performSegue(withIdentifier: "homeToPhotoDetailSegue", sender: self.contentID)
//        case 3:
//            grandgrandparent.performSegue(withIdentifier: "homeToPhotoDetailSegue", sender: self.contentID)
//            
//        default:
//            grandgrandparent.performSegue(withIdentifier: "homeToPhotoDetailSegue", sender: self.contentID)
//        }
        
        //grandparent.performSegue(withIdentifier: "HomeCarouselToDetail", sender: self)
        //print(parent.CarouselImageSet.index(of: self.imageName!))
    }
    
    
    //    func fetchImage(url:String) -> UIImage? {
    //        var result:UIImage? = nil
    //        let addr = url
    //
    //        if let imageFromCache=imageCache.object(forKey: addr as NSString) {
    //            //print("[succeeded]Found in cache image from\(addr)")
    //            result=imageFromCache
    //        }else{
    //            if let resultImage = self.checkCache(url: addr as NSString, context: self.context!) {
    //                imageCache.setObject(resultImage, forKey: addr as NSString)
    //                result=resultImage
    //            }else{
    //                if let image = self.DownloadAndSaveImageToCache(Url:addr){
    //                    result=image
    //                }
    //            }
    //        }
    //
    //
    //    return result
    //
    //}
    
    
    
    
    
    
    
    
    
}

class carouselInfo {
    var cover:String?
    var type:Int?
    var ID:Int?
}
