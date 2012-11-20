ClrBclInLua - An implementation of the .NET Framework BCL in pure Lua
---------------------------------------------------------------------

Why? Because I missed the simplicity of the .NET Framework.
I am open to new project names.

The ClrBclInLua project aims to implement as much of the .NET BCL in Lua as possible.
Currently, it has implemented:
- Exceptions
- A type system (Interfaces, Inheritance)
- The base object class (System.Object)

Issues:
- Anything can be redefined or changed, there is no readonly object

It's other goals:
- Support for multiple platforms (See System\Platform.lua)
- All string resources are stored in System\LocalizedResources.lua and System\Resources.lua, to make multi-language support easy and simple
- Provide support for all of the Roblox classes/types

Copyright (C) 2012 LoDC