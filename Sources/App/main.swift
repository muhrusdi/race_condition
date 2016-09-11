import Vapor
import HTTP

let drop = Droplet()
let _ = drop.config["app", "key"]?.string ?? ""

drop.get("/") { request in
    return try drop.view.make("index")
}

let users = UserController(droplet: drop)
drop.resource("users", users)

drop.get("leaf") { request in
    return try drop.view.make("template", [
        "greeting": "Hello, world!"
    ])
}

drop.middleware.append(SampleMiddleware())

let port = drop.config["app", "port"]?.int ?? 80

drop.serve()
