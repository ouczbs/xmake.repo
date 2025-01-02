on_install(function(package)
    local configs = {kind = "static"}
    package:config_set("debug",true)
    import("package.tools.xmake").install(package, configs)
end)
on_fetch(function(package, opt)
    package:config_set("debug",true)
    package:config_set("runtimes","c++_static")
    local root = package:sourcedir()
    os.cd(root)
    local buildir = package:buildir()
    buildir = path.join(root, buildir, os:host(), package:arch(), package:mode())
    import("package.tools.xmake").install(package, {kind = "static"})
    local includedirs = {path.join(root, "include")}
    local links = {package:name()}
    return {
        includedirs = includedirs, linkdirs = buildir, links = links
    }
end)