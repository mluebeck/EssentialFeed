//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import CoreData
import EssentialFeed
import EssentialFeediOS
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var store: FeedStore & FeedImageDataStore = {
        try! CoreDataFeedStore(
            storeURL: NSPersistentContainer
                .defaultDirectoryURL()
                .appendingPathComponent("feed-store.sqlite"))
    }()

    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()

    convenience init(httpClient: HTTPClient, store: FeedStore & FeedImageDataStore) {
        self.init()
        self.httpClient = httpClient
        self.store = store
    }
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
         
        let remoteImageLoader = RemoteFeedImageDataLoader(client: httpClient)
        let localImageLoader = LocalFeedImageDataLoader(store: store)
        
        window?.rootViewController = UINavigationController(
            rootViewController: FeedUIComposer.feedComposedWith(
                feedLoader: makeRemoteFeedLoaderWithLocalFallback,
                imageLoader: FeedImageDataLoaderWithFallbackComposite(
                    primary: localImageLoader,
                    fallback: FeedImageDataLoaderCacheDecorator(
                        decoratee: remoteImageLoader,
                        cache: localImageLoader))))
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        localFeedLoader.validateCache { _ in }
    }
    
    
    private func makeRemoteFeedLoaderWithLocalFallback() -> RemoteFeedLoader.Publisher {
        let remoteURL = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
        let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: httpClient)
        return remoteFeedLoader.loadPublisher().caching(to: localFeedLoader).fallback(to: localFeedLoader.loadPublisher)
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
 

extension FeedLoader {
    public typealias Publisher = AnyPublisher<[FeedImage],  Error>
    
    public func loadPublisher() -> Publisher {
        Deferred {
            Future(self.load)
        }.eraseToAnyPublisher()
    }
}

private extension FeedCache {
    func saveIgnoringResult(_ feed: [FeedImage]) {
        save(feed) { _ in }
    }
}

extension Publisher where Output == [FeedImage] {
    func caching(to cache:FeedCache)->AnyPublisher<Output,Failure> {
        handleEvents(receiveOutput:cache.saveIgnoringResult).eraseToAnyPublisher()
    }
}

extension Publisher {
    func fallback(to fallbackPublisher: @escaping () -> AnyPublisher<Output,Failure>) -> AnyPublisher<Output,Failure> {
        self.catch{ _ in fallbackPublisher() }.eraseToAnyPublisher()
        
    }
}
 
extension Publisher {
    func dispatchOnMainQueue() -> AnyPublisher<Output,Failure> {
        receive(on: DispatchQueue.immediateWhenOnMainQueueScheduler).eraseToAnyPublisher()
    }
}

extension DispatchQueue {
    
    static var immediateWhenOnMainQueueScheduler : ImmediateWhenOnMainQueueScheduler {
        ImmediateWhenOnMainQueueScheduler()
    }
    
    struct ImmediateWhenOnMainQueueScheduler : Scheduler {
        typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
        typealias SchedulerOptions = DispatchQueue.SchedulerOptions
        
        var now: SchedulerTimeType {
            DispatchQueue.main.now
        }
        
        var minimumTolerance: SchedulerTimeType.Stride {
            DispatchQueue.main.minimumTolerance
        }
        
        func schedule(options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) {
            guard Thread.isMainThread else {
                return DispatchQueue.main.schedule(options: options, action)
            }
            action()
        }
        
        func schedule(after date: DispatchQueue.SchedulerTimeType, interval: DispatchQueue.SchedulerTimeType.Stride, tolerance: DispatchQueue.SchedulerTimeType.Stride, options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
            DispatchQueue.main.schedule(after: date, interval: interval,tolerance: tolerance, options: options, action)
        }
        
        func schedule(after date: DispatchQueue.SchedulerTimeType, tolerance: DispatchQueue.SchedulerTimeType.Stride, options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) {
            DispatchQueue.main.schedule(after: date, tolerance: tolerance, options: options, action)
        }
    }
}
