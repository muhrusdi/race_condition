import Vapor
import HTTP

let drop = Droplet()
let _ = drop.config["app", "key"]?.string ?? ""

drop.get("/") { request in
    return try drop.view.make("index")
}

drop.get("faq") { request in
    return try drop.view.make("faq")
}

drop.get("apply") { request in
    return try drop.view.make("apply")
}

drop.get("login") { request in
    return try drop.view.make("login")
}

let users = UserController(droplet: drop)
drop.resource("users", users)


drop.middleware.append(SampleMiddleware())

let port = drop.config["app", "port"]?.int ?? 80

drop.serve()
