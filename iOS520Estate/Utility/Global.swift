//
//  Global.swift
//  iOS520Estate
//
//  Created by Yonglun Liu on 2017/8/27.
//  Copyright © 2017年 YonglunTech. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: - Device Information
let screenSize: CGRect = UIScreen.main.bounds

let screenWidth = screenSize.width
let screenHeight = screenSize.height
var tabbarHeight=0.0
let screenScale=UIScreen.main.scale


// MARK: - Artwork

let globalTintColor = UIColor(red: 122/255.0,green: 161/255.0,blue: 204/255.0,alpha:1)
let globalBackgroundColor = UIColor(red: 246/255.0,green: 249/255.0,blue: 225/255.0,alpha:1)
let globalLoadingColor = UIColor(red: 111/255.0,green: 111/255.0,blue: 111/255.0,alpha:1)
let complexBackgroundColor = UIColor(red: 165/255.0,green: 222/255.0,blue: 243/255.0,alpha:1)
let priceColor = UIColor(red: 255/255.0,green: 66/255.0,blue: 66/255.0,alpha:1)
let imageBorderColor = UIColor(red: 0/255.0,green: 0/255.0,blue: 0/255.0,alpha:0.3)





//Mark: - Cache System
let imageCache = NSCache<NSString,UIImage>()
var imageData:[String:NSData]=[:]


//Mark: - utility function

func fetchImage(url:String) -> UIImage? {
    var result:UIImage? = nil
    let addr = url
    
    if let imageFromCache=imageCache.object(forKey: addr as NSString) {
        //print("[succeeded]Found in cache image from\(addr)")
        result=imageFromCache
    }else{
        if let image = DownloadAndSaveImageToCache(Url:addr){
            result=image
        }
    }
    
    
    return result
    
}



func DownloadAndSaveImageToCache(Url:String) -> UIImage? {
    //    do{
    let escape = (Url).addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
    
    if let u=URL(string:escape){
        
        if let data = try? Data(contentsOf: u)  {
            let originImage=UIImage(data:data)
            imageData[Url]=data as NSData?
            imageCache.setObject(originImage!, forKey: Url as NSString)
            //            DispatchQueue.global(qos:.background).asyncAfter(deadline: .now()+3, execute: {
            //                if let entry = NSEntityDescription.insertNewObject(forEntityName: "GeneralImageCache", into: context!) as? GeneralImageCache{
            //                    entry.data = data as NSData?
            //                    entry.url = Url
            //                    //try context?.save()
            //                }
            //
            //            })
            return originImage
            
            
        }else{
            let u=URL(string:Url) ?? URL(string:"https://itakeimg.oss-cn-beijing.aliyuncs.com/Application/utility/broken.png")!
            if let data = try? Data(contentsOf: u)  {
                imageData[Url]=data as NSData?
                
                print("[Data] Data downlowded \(data.count) for url:\(u)")
                let originImage=UIImage(data:data)
                imageCache.setObject(originImage!, forKey: Url as NSString)
                
                
                //                DispatchQueue.global(qos:.background).asyncAfter(deadline: .now()+2, execute: {
                //                    if let entry = NSEntityDescription.insertNewObject(forEntityName: "GeneralImageCache", into: context!) as? GeneralImageCache{
                //                        entry.data = data as NSData?
                //                        entry.url = Url
                //                        //try context?.save()
                //                    }
                //
                //                })
                
                return originImage
                
                
            }else{
                print("catch point hit")
                return UIImage(named:"broken.png")
            }
        }
    }else{
        let u = URL(string:(Url as NSString).addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!) ?? URL(string:"https://itakeimg.oss-cn-beijing.aliyuncs.com/Application/utility/broken.png")!
        
        
        //addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
        //print(u)
        if let data = try? Data(contentsOf: u)  {
            imageData[Url]=data as NSData?
            
            let originImage=UIImage(data:data)
            imageCache.setObject(originImage!, forKey: Url as NSString)
            
            return originImage
            
            
        }else{
            print("catch point hit")
            return UIImage(named:"broken.png")
        }
    }
    
    //    }catch{
    //        print("catch point hit")
    //        return nil
    //    }
}



//func checkCache(url:NSString,context:NSManagedObjectContext) -> UIImage? {
//    print("checking cache for url:\(url)")
//    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GeneralImageCache")
//    request.fetchBatchSize = 1
//    request.fetchLimit = 1
//    request.sortDescriptors = []
//    let predicate = NSPredicate(format: "url = %@", url)
//    request.predicate = predicate
//    
//    if let result = try? context.fetch(request) as! [GeneralImageCache]{
//        
//        if result.count<1 {
//            print("[failed]did not find cache for url:\(url)")
//            return nil
//        }else{
//            print("[succeeded]did find cache url:\(url)")
//            let image=UIImage(data:result[0].data as! Data)!
//            return image
//        }
//    }
//    return nil
//}
//

//
//func saveImagesToCoreData(context:NSManagedObjectContext,data:[String:NSData]){
//    for item in data{
//        print("[Data] save image to core URL:\(item.key)")
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GeneralImageCache")
//        request.fetchBatchSize = 1
//        request.fetchLimit = 1
//        request.sortDescriptors = []
//        let predicate = NSPredicate(format: "url = %@", item.key)
//        request.predicate = predicate
//        
//        if let result = try? context.fetch(request) as! [GeneralImageCache]{
//            
//            if result.count<1 {
//                print("[failed]did not find cache for url:\(item.key)")
//                if let entry = NSEntityDescription.insertNewObject(forEntityName: "GeneralImageCache", into: context) as? GeneralImageCache{
//                    entry.data = item.value
//                    entry.url = item.key
//                }
//            }else{
//                print("[succeeded]did find cache url:\(item.key)")
//            }
//        }
//        
//    }
//    try? context.save()
//    imageData.removeAll()
//    
//}
