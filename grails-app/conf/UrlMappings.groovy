class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
//        "/"(redirect:[uri:"/index"])
        "/index"(view:"/home/index")
//        "/search"(controller:'home')
        "/about"(view:'/about')
        "/contact"(view:'/contact')
        "500"(view:'/error')
	}
}
