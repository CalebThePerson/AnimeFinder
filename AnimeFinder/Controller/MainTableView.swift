//
//  MainTableView.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/4/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableView: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, AnimeDelagate {
    
    //Variables like API Struct, and Anime results we have saved
    let realm = try! Realm()
    var TraceMoe = TraceMoeAPI()
    var Anime: Results<AnimeInfo>?
    
    //MARK: - ImagePickerButton
    //Creates an Imager picker, makes the source the photolibrary
    let ImagePicker = UIImagePickerController()

    @IBAction func ImageAdder(_ sender: Any) {
        ImagePicker.allowsEditing = false
        ImagePicker.sourceType = .photoLibrary
        
        present(ImagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        Reload()
        super.viewDidLoad()
        //Delegates and references?
        tableView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "Skadosh")
        tableView.dataSource = self
        tableView.rowHeight = 100
        ImagePicker.delegate = self
        TraceMoe.Delegate = self

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Anime?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Skadosh", for: indexPath) as! PhotoCell
        
        if let AnimeStuff = Anime?[indexPath.row] {
            cell.imageView?.image = self.convertBase64ToImage(AnimeStuff.ImageString)
//            cell.imageView?.contentMode = .center
            

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //We are creating the popover segue manually
        //First we are linking the view together and giivng it the popover effect
        let PopOverVC = storyboard?.instantiateViewController(withIdentifier: "MainView") as! MainView
        PopOverVC.modalPresentationStyle = .popover
        
        //Assigning variables to the view and properties and etc
        if let CurrentAnime = Anime?[indexPath.row] {
            print(CurrentAnime.Name)
            PopOverVC.Anime = CurrentAnime
        }
        
        //Having it be presented
        present(PopOverVC, animated:true, completion: nil)
        
        //Some other important stuff
        let popoverController = PopOverVC.popoverPresentationController
        popoverController!.sourceView = self.view
        popoverController!.permittedArrowDirections = .any
        

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - ReloadFunction
    
    func Reload() {
        Anime = realm.objects(AnimeInfo.self)
        
        tableView.reloadData()
        print("reloaded")
    }
    
}


//MARK: - Extenions

extension MainTableView {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //Once the image is picked, it converts it to the string and calls the API
            let TheString = convertImageToBase64(pickedImage)
            TraceMoe.API(ImageString: TheString)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Image conversion Functions
    //Function to convert string to image
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
    //Function to convert Image to string
    func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
}

