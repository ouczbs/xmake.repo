package("mimalloc")
    set_homepage("https://github.com/microsoft/mimalloc")
    set_description("A general purpose allocator with high performance and small memory footprint")
    add_versions("2.1.7", "...")
    add_configs("secure", {description = "Use a secured version of mimalloc", default = false, type = "boolean"})
    add_configs("copy", {description = "wheter copy lib to buildir", default = false, type = "boolean"})
    -- 定义安装 mimalloc 的过程
    set_sourcedir(path.join(os.scriptdir(), "latest"))
    on_fetch(function(package, opt)
        import("mimalloc_build")
        mimalloc_build(package)
        local root = package:sourcedir()
        local includedirs = {path.join(root, "include")}
        local mode = package:config("debug") and "Debug" or "Realease"
        local linkdirs = {path.join(root, "build/" .. mode)}
        local links = {package:name()}
        return {
            includedirs = includedirs, linkdirs = linkdirs, links = links
        }
    end)