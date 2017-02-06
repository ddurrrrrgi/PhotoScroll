//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by RGP_KOREA on 2017. 2. 6..
//  Copyright © 2017년 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        // 1
        if let viewController = viewPhotoCommentController(index: currentIndex) {
            let viewControllers = [viewController]
            // 2
            setViewControllers(
                viewControllers,
                direction: .forward,
                animated: false,
                completion: nil
            )
        }
        
        view.backgroundColor = UIColor.white    
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.blue
        UIPageControl.appearance().backgroundColor = UIColor.white
    }

    func viewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
        if let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController")
                as? PhotoCommentViewController {
            page.photoName = photos[index]
            page.photoIndex = index
            return page
        }
        
        return nil
    }

}

extension ManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex, index - 1 >= 0 else {
                return nil
            }
            return viewPhotoCommentController(index: index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex, index + 1 < photos.count else {
                return nil
            }
            return viewPhotoCommentController(index: index + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
