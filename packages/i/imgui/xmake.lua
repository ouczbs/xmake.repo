package("imgui")
    set_homepage("https://github.com/ocornut/imgui")
    set_description("v1.90.6")
    set_sourcedir(path.join(os.scriptdir(), "latest"))
    add_configs("copy", {description = "wheter copy lib to buildir", default = false, type = "boolean"})
    on_fetch(function(package, opt)
        package:config_set("debug",true)
        package:config_set("runtimes","c++_shared")
        local root = package:sourcedir()
        os.cd(root)
        local buildir = package:buildir()
        buildir = path.join(root, buildir, os:host(), package:arch(), package:mode())
        import("package.tools.xmake").install(package, {kind = "shared"})
        local includedirs = {path.join(root, "include")}
        local links = {package:name()}
        return {
            includedirs = includedirs, linkdirs = buildir, links = links
        }
    end)
