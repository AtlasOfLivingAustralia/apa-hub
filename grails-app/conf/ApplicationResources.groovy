modules = {
//    application {
//        resource url:'js/application.js'
//    }

    // Define your skin module here - it must 'dependsOn' either bootstrap (ALA version) or bootstrap2 (unmodified) and core

    apa {
        dependsOn 'bootstrap2', 'hubCore' //
        resource url: [dir:'css', file:'apa-styles.css']
    }

}