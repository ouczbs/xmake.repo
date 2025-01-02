package("dxsdk11")
    set_sourcedir(path.join(os.scriptdir(), "latest"))

    on_install(function(package)
        import("package.tools.xmake").install(package, {})
    end)