//
//  ImagesManager.swift
//  SecretGallery
//
//  Created by Admin on 21.10.23.
//

import Foundation
import UIKit

class ImagesManager {
    
    static let shared = ImagesManager()
    
    private let fileManager = FileManager.default
    
    public var imagesCount: Int
    
    public lazy var imagesArray = getImagesFromDirectory()
    
    private init() {
        
        do {
            
            let count = try fileManager.contentsOfDirectory(atPath: fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].path).count
            self.imagesCount = count - 1
            return
        }
        catch {
            
            print(error)
        }
        
        self.imagesCount = 0
    }
    
    public func saveImage(withImage image: UIImage) {
        
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let data = image.jpegData(compressionQuality: 1.0)
        
        var name = imagesCount
        var fileUrl = url.appendingPathComponent("\(name).jpeg")
        while fileManager.fileExists(atPath: fileUrl.path) {
            name += 1
            fileUrl = url.appendingPathComponent("\(name).jpeg")
        }
        
        fileManager.createFile(atPath: fileUrl.path, contents: data)
        imagesArray = getImagesFromDirectory()
    }
    
    public func deleteImage(withIndex index: Int) {
        
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let urlToDelete = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)[index]
            try fileManager.removeItem(at: urlToDelete)
            imagesArray = getImagesFromDirectory()
        }
        catch {
            print (error)
        }
    }
    
    private func getImagesFromDirectory() -> [UIImage] {
        var images = [UIImage]()
        do {
            
            let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let urls = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for url in urls {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                     images.append(image)
                }
            }
        } catch {
            print(error)
        }
        
        imagesCount = images.count
        return images
    }
    
}
