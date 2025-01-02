package("imgui-node-editor")
    set_homepage("https://github.com/thedmd/imgui-node-editor")
    set_description("Node Editor for dear imgui v0.9.3")
    set_sourcedir(path.join(os.scriptdir(), "latest"))

    on_install(function(package)
        import("package.tools.xmake").install(package, {})
    end)