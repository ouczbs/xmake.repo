
package("USmallFlat")
    set_kind("library", {headeronly = true})
    set_urls("https://github.com/Ubpa/USmallFlat.git")
    add_includedirs("include")
    on_install(function (package)
        os.cp("include", package:installdir())
    end)