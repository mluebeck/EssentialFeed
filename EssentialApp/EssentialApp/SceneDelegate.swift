//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import CoreData
import EssentialFeed
import EssentialFeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
    
    private lazy var httpClient : HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    } ()
    
    private lazy var store : FeedStore & FeedImageDataStore = {
        try! CoreDataFeedStore(storeURL: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite"))
    } ()
    
    convenience init(httpClient: HTTPClient, store: FeedStore & FeedImageDataStore) {
        self.init()
        self.httpClient = httpClient
        self.store = store
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        configureWindow()
    }
    
    func configureWindow() {
        let remoteURL = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
        
        let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: httpClient)
        let remoteImageLoader = RemoteFeedImageDataLoader(client: httpClient)

         
         let localFeedLoader = LocalFeedLoader(store: store, currentDate: Date.init)
        let localImageLoader = LocalFeedImageDataLoader(store: store)
       
        let feedLoaderCacheDecorator = FeedLoaderCacheDecorator(decoratee: remoteFeedLoader, cache: localFeedLoader)
        
        let feedLoader = FeedLoaderWithFallbackComposite(primary: feedLoaderCacheDecorator, fallback: localFeedLoader)
        
        let feedImageLoaderCacheDecorator = FeedImageDataLoaderCacheDecorator(decoratee: remoteImageLoader, cache: localImageLoader)
        
        let imageLoader = FeedImageDataLoaderWithFallbackComposite(primary: feedImageLoaderCacheDecorator, fallback: remoteImageLoader)
        
        let viewController = FeedUIComposer.feedComposedWith(feedLoader:feedLoader, imageLoader:imageLoader )
 
        window?.rootViewController = UINavigationController(rootViewController: viewController)
	}
}

class AlwaysFailingHTTPClient: HTTPClient {
    private class Task: HTTPClientTask {
        func cancel() {
        }
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        completion(.failure(NSError(domain: "offline", code: 0)))
        return Task()
    }
}
 
