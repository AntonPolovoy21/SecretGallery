//
//  GalleryViewController.swift
//  SecretGallery
//
//  Created by Admin on 19.10.23.
//

import Foundation
import UIKit
import SnapKit

class GalleryViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.identifier)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private var collectionViewCount = 3.0
    private let collectionViewSpacing = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.bottom.left.right.equalToSuperview()
        }
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        navigationItem.rightBarButtonItem?.action = #selector(addPhoto)
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.tintColor = .systemPurple
        title = "Your secret gallery"
    }
    
    @objc private func addPhoto() {
        let alert = UIAlertController(title: "Choose option", message: "", preferredStyle: .actionSheet)
        alert.view.tintColor = .systemPurple
        alert.addAction(UIAlertAction(title: "By URL", style: .default))
        alert.addAction(UIAlertAction(title: "Take a picture", style: .default))
        alert.addAction(UIAlertAction(title: "From your phone's gallery", style: .default, handler:  fromGallery(_:)))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func fromGallery(_ action: UIAlertAction) {
        
        
//        PHPickerViewController
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        present(vc, animated: true)
    }
}

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImagesManager.shared.saveImage(withImage: image)
        }
        picker.dismiss(animated: true)
        collectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        collectionView.reloadData()
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ImagesManager.shared.deleteImage(withIndex: indexPath.row)
        collectionView.reloadData()
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        ImagesManager.shared.imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as? GalleryCell else { return UICollectionViewCell() }
        cell.configure(withImage: ImagesManager.shared.imagesArray[indexPath.row])
        return cell
    }
    
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = (collectionView.frame.width - collectionViewSpacing * (collectionViewCount - 1)) / collectionViewCount
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionViewSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        collectionViewSpacing
    }
}
