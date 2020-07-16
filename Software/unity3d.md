Setup with dotnet and vscode
=====
* Linux
    * $ app-fast -S dotnet-sdk mono mono-tools
* Windows
    * $ choco install dotnetcore-sdk -y
* Install unityhub then install unity (Login with joeky5888@gmail.com)
* Install vscode not vscodium # Because vscodium doesn't compatible with these extensions
    * Install extension "@id:Unity.unity-debug"
    * Install extension "@id:ms-dotnettools.csharp"
* Unity Editor ->
    * Edit -> Preferences -> External Tools ->
        * External Script Editor -> Browse -> /var/lib/snapd/snap/bin/code
        * External Script Editor Args -> Clear all args then press Enter
    * Assets -> Open C# Project # Should wait for a while to get completion working, like 1min
* Add launch.json and start debugger in vscode (Click the play button)
* UnityEditor -> Click play button to start debugging in vscode

