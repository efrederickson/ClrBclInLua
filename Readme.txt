ClrBclInLua - An implementation of the .NET Framework BCL in pure Lua
---------------------------------------------------------------------

Why? Because I missed the simplicity of the .NET Framework.
I am open to new project names.

Note: The new build system requires the .NET Framework 4.0, its a C# project

The ClrBclInLua project aims to implement as much of the .NET BCL in Lua as possible.

Currently, it has implemented:
- Exceptions
- A type system (Interfaces, Inheritance), which I am beginning to automate
- The base object class (System.Object)

What won't be implemented:
- MSIL Emitting classes/Assembly loading
- Many of the classes that relied upon native code

Issues:
- Anything can be redefined or changed, there is no readonly object

It's other goals:
- Support for multiple platforms (See System\Platform.lua)
- All string resources are stored in System\LocalizedResources.lua and System\Resources.lua, to make multi-language support easy and simple
- Provide support for all of the Roblox classes/types

Copyright (C) 2012 LoDC