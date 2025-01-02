local lua_xmake = [[
local kind = "%s"
add_requires("lua")
target("luasocket")
    set_basename("core")
    set_kind(kind)
    add_packages("lua")
    add_syslinks("ws2_32")
    add_files("src/auxiliar.c","src/buffer.c","src/compat.c" ,"src/except.c" ,"src/inet.c")
    add_files("src/io.c","src/luasocket.c","src/options.c" ,"src/select.c" ,"src/tcp.c")
    add_files("src/timeout.c","src/udp.c","src/wsocket.c")
    add_headerfiles("src/*.h")
]]
package("luasocket")
    set_urls("https://github.com/lunarmodules/luasocket.git")
    add_includedirs("include")
    on_install("macosx", "linux", "windows", function (package)
        io.writefile("xmake.lua", format(lua_xmake,"shared"))
        local configs = {kind = "shared"}
        import("package.tools.xmake").install(package, configs)
    end)