////
////  ViewController.swift
////  Prototype_For_Tokerism
////
////  Created by Ian CHAN on 17/12/2023.
////

import UIKit
import Vision

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func readTapped(_ sender: UIButton) {
        recogniseText(in: UIImage(named: "BlackmanTest")!)
    }
    
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
//        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
//        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func openCameraLibrary(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        vc.showsCameraControls = true
        present(vc, animated: true)
        
//        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
//        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    func recogniseText(in image: UIImage) {
        guard let cgImage = image.cgImage else {
            return
        }
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .up)
        
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let bounds = CGRect(origin: .zero, size: size)
        
        let request = VNRecognizeTextRequest { request, error in
            guard let results = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            let string = results.compactMap {
                $0.topCandidates(1).first?.string
            }.joined(separator: "\n")
            
            print(string)
            
            DispatchQueue.main.async{
                let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
                storyboard.text = string
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform([request])
            } catch {
                print("Failed to perform image request: \(error)")
                return
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            recogniseText(in: image)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            recogniseText(in: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
