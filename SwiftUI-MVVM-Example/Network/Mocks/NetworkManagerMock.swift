//
//  NetworkManagerMock.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 19.11.2022.
//

import Foundation

class NetworkManagerMock: NetworkManagerProtocol {
    static var shared: NetworkManager = NetworkManager()

    var invokedApiRequest = false
    var invokedApiRequestCount = 0
    var invokedApiRequestParameters: (endpoint: URL, param: Data?)?
    var invokedApiRequestParametersList = [(endpoint: URL, param: Data?)]()
    var stubbedApiRequestCompletionResult: (Result<Data, RequestErrors>, Void)?

    func apiRequest(endpoint: URL, param: Data?, completion: @escaping (Result<Data, RequestErrors>) -> Void) {
        invokedApiRequest = true
        invokedApiRequestCount += 1
        invokedApiRequestParameters = (endpoint, param)
        invokedApiRequestParametersList.append((endpoint, param))
        if let result = stubbedApiRequestCompletionResult {
            completion(result.0)
        }
    }

    var invokedCreatePosterimageUrl = false
    var invokedCreatePosterimageUrlCount = 0
    var invokedCreatePosterimageUrlParameters: (path: String?, Void)?
    var invokedCreatePosterimageUrlParametersList = [(path: String?, Void)]()
    var stubbedCreatePosterimageUrlResult: String! = ""

    func createPosterimageUrl(withPath path: String?) -> String {
        invokedCreatePosterimageUrl = true
        invokedCreatePosterimageUrlCount += 1
        invokedCreatePosterimageUrlParameters = (path, ())
        invokedCreatePosterimageUrlParametersList.append((path, ()))
        return stubbedCreatePosterimageUrlResult
    }

    var invokedCreateBackdropimageUrl = false
    var invokedCreateBackdropimageUrlCount = 0
    var invokedCreateBackdropimageUrlParameters: (path: String?, Void)?
    var invokedCreateBackdropimageUrlParametersList = [(path: String?, Void)]()
    var stubbedCreateBackdropimageUrlResult: String! = ""

    func createBackdropimageUrl(withPath path: String?) -> String {
        invokedCreateBackdropimageUrl = true
        invokedCreateBackdropimageUrlCount += 1
        invokedCreateBackdropimageUrlParameters = (path, ())
        invokedCreateBackdropimageUrlParametersList.append((path, ()))
        return stubbedCreateBackdropimageUrlResult
    }

    var invokedCreateOriginalImageUrl = false
    var invokedCreateOriginalImageUrlCount = 0
    var invokedCreateOriginalImageUrlParameters: (path: String?, Void)?
    var invokedCreateOriginalImageUrlParametersList = [(path: String?, Void)]()
    var stubbedCreateOriginalImageUrlResult: String! = ""

    func createOriginalImageUrl(withPath path: String?) -> String {
        invokedCreateOriginalImageUrl = true
        invokedCreateOriginalImageUrlCount += 1
        invokedCreateOriginalImageUrlParameters = (path, ())
        invokedCreateOriginalImageUrlParametersList.append((path, ()))
        return stubbedCreateOriginalImageUrlResult
    }

    var invokedCreateLogoimageUrl = false
    var invokedCreateLogoimageUrlCount = 0
    var invokedCreateLogoimageUrlParameters: (path: String?, Void)?
    var invokedCreateLogoimageUrlParametersList = [(path: String?, Void)]()
    var stubbedCreateLogoimageUrlResult: String! = ""

    func createLogoimageUrl(withPath path: String?) -> String {
        invokedCreateLogoimageUrl = true
        invokedCreateLogoimageUrlCount += 1
        invokedCreateLogoimageUrlParameters = (path, ())
        invokedCreateLogoimageUrlParametersList.append((path, ()))
        return stubbedCreateLogoimageUrlResult
    }

    var invokedCreateRequestURL = false
    var invokedCreateRequestURLCount = 0
    var invokedCreateRequestURLParameters: (endpoint: String, pathVariables: [String]?, headerParams: [String: Any]?)?
    var invokedCreateRequestURLParametersList = [(endpoint: String, pathVariables: [String]?, headerParams: [String: Any]?)]()
    var stubbedCreateRequestURLResult: URL! = URL(string: AppConstants.shared.exampleImagePath)!

    func createRequestURL(_ endpoint: String, pathVariables: [String]?, headerParams: [String: Any]?) -> URL {
        invokedCreateRequestURL = true
        invokedCreateRequestURLCount += 1
        invokedCreateRequestURLParameters = (endpoint, pathVariables, headerParams)
        invokedCreateRequestURLParametersList.append((endpoint, pathVariables, headerParams))
        return stubbedCreateRequestURLResult
    }
}
