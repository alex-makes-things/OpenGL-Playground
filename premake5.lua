workspace "My GLFW Attempt"
	configurations {"Debug", "Release", "Dist"}
	architecture "x86"
	startproject "App"


outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "App"
	
	language "C++"
	cppdialect "C++20"
	location "Build/%{prj.name}"
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")

	files{
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/src/**.h"
	}


	libdirs{
		("Vendor/GLFW/lib-vc2022")
	}
	includedirs{
		("Vendor/GLFW/include")
	}
	links {
		"Opengl32",
		"glfw3"
	}

	filter { "configurations:Dist" }
		kind "WindowedApp"
		defines "NDEBUG"
		optimize "On"

	filter { "configurations:Debug" }
		kind "ConsoleApp"
		defines "DEBUG"
		symbols "On"

	filter { "configurations:Release" }
		kind "ConsoleApp"
		defines "NDEBUG"
		optimize "On"

	filter { "configurations:Dist" , "system:Windows" }
		system "windows"
		entrypoint "mainCRTStartup"