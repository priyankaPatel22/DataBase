//
//  ViewController.swift
//  delete_Demoes
//
//  Created by Priyanka Patel on 28/07/17.
//  Copyright © 2017 Priyanka Patel. All rights reserved.
//

import UIKit
//import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var dataArr = NSArray()
    
    //For Pasignation
    var pageNum:Int!
    var isLoading:Bool?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pageNum=1;
        let indicator1 = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator1.startAnimating()
        
        //dataArr = ["kaka","mama"]
        var names = [String]()

        let urlString = "https://api.androidhive.info/json/movies.json"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let arrDummy:NSArray = try JSONSerialization.jsonObject(with: data!) as Any as! NSArray

                    var i:Int?
                    for arr in arrDummy
                    {
                        //i=i!+1
                      //  print("\(arr)")
                        
                        let fileManager = FileManager.default
                        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("img\(i).png")
                        
                        
                        let str=(arr as AnyObject).value(forKey: "image") as! String
                        let catPictureURL = URL(string: str)!
                        
                        let data=NSData(contentsOf: catPictureURL)
                        
                        data?.write(toFile: paths, atomically: true)
                        
                        
                        let qury="INSERT INTO Student(name,imgPic) VALUES(\"\((arr as AnyObject).value(forKey: "title") as! String)\",\"img\(i).png\")"
                        Database.share().insert(qury)
                    }
                   
                    
                   // let qury="INSERT INTO Student(name) VALUES (\'hiii\')"
                  //  Database.share().insert(qury)
                    
                    let qury1="SELECT * FROM Student"
                    self.dataArr=Database.share().selectAll(fromTable: qury1) as NSMutableArray
                    
                    print("\(self.dataArr)")
                    
                    self.myTableView.reloadData()
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        print(names)
        
        
        
        //dataArr = ["kaka","mama"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        
        let label:UILabel = cell.viewWithTag(2) as! UILabel
        let imgUser=cell.viewWithTag(1) as! UIImageView
        let acti_Indecater=cell.viewWithTag(3) as! UIActivityIndicatorView
        
       /// label.text = (dataArr.object(at: indexPath.row) as? AnyObject)?.value(forKey: "title") as? String
        label.text=(dataArr.object(at: indexPath.row) as AnyObject).value(forKey: "name") as? String
        
//        let catPictureURL = URL(string: "http://api.androidhive.info/json/movies/14.jpg")!
//        let data = try? Data(contentsOf: catPictureURL)
//        if let imageData = data {
//            imgUser.image=UIImage(data: imageData)
//        }
        
        let images = (dataArr.object(at: indexPath.row) as? AnyObject)?.value(forKey: "imgPic") as? String
        if(images==nil)
        {
            acti_Indecater.isHidden=true
        }
        else
        {
            acti_Indecater.isHidden=false
            acti_Indecater.startAnimating()
            
            imgUser.sd_setImage(with: URL(string: images!), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                // Perform operation.
                
                acti_Indecater.isHidden=true
            })
            
            
        }
        //imgUser.sd_setImage(with: URL(string: images!), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        return cell
    }
    
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == myTableView {
//            if isLoading == true{
//                if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
//                    pageNum = pageNum + 1
//                    print(pageNum)
//                    isLoading = false
//                    
////                    if Reachability.isConnectedToNetwork() == true {
////                        self.addLoadingIndicatiorOnFooterOnTableView()
////                        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.postDataOnWebserviceForGetScheduleDish), userInfo: nil, repeats: false)
////                    } else {
////                        showAlert("Check Connection", title: "Internet is not available.")
////                    }
//                }
//            }
//            
//        }
//        
//    }

    
    
    
}

