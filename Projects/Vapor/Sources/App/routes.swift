import Vapor

func routes(_ app: Application) throws {
    
    let backgroundQueue = DispatchQueue.global(qos: .userInitiated)
    
    app.get { req in
        return "It works!"
    }

    app.get("simple") { req -> Int in
        Utils.getSimpleResponse()
    }
    
    app.get("json") { req -> JsonResponse in
        Utils.getHarderResponse()
    }
    
    app.get("static") { req -> EventLoopFuture<Int> in
        let promise = req.eventLoop.makePromise(of: Int.self)
        backgroundQueue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            promise.succeed(Utils.getSimpleResponse())
        }
        return promise.futureResult
    }
}

extension JsonResponse: ResponseEncodable {
    func encodeResponse(for request: Request) -> EventLoopFuture<Vapor.Response> {
        let value = (try? JSONEncoder().encode(self)) ?? "".data(using: .utf8)!
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/json")
        return request.eventLoop.makeSucceededFuture(.init(
            status: .ok, headers: headers, body: .init(data: value)
        ))
    }
}

extension JsonResponse: Content {
    static var defaultContentType: HTTPMediaType {
        .json
    }
}
