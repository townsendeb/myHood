//
//  AddPostVC.swift
//  MyHood
//
//  Created by Eric Townsend on 1/21/16.
////  Copyright © 2016 KrimsonTech. All rights reserved.
////

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var postImg: UIImageView!
    
    var imgPicker: UIImagePickerController!
    
    override func viewDidLoad () {
        super.viewDidLoad()
        
        postImg.layer.cornerRadius = postImg.frame.size.width/2
        postImg.clipsToBounds = true
        
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
    }
    @IBAction func addPicButton(sender: UIButton!) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func postItButton(sender: AnyObject) {
        
        if let newTitle = titleField.text, let newDesc = descField.text, let newImg = postImg.image {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(newImg)
            let post = Post(imagePath: imgPath, title: newTitle, description: newDesc) //creates new post with image title and desc
            DataService.instance.addPost(post) //adds post to post in Data service
            
            dismissViewControllerAnimated(true, completion: nil)
        }

    }
    
    @IBAction func cancelPostButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imgPicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
        
    }
}
