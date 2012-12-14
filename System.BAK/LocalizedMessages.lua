System.LocalizedMessages = {
    ["en-US"] = {
        Exception_EndOfInnerExceptionStack = "--- End of inner exception stack trace ---",
        String_Remove_StartIsInvalid = "Start index to System.String.Remove is invalid, it must be greater than 0",
        ArgumentOutOfRange_InvalidUTF32 = "A valid UTF32 value is between 0x000000 and 0x10ffff, inclusive, and should not include surrogate codepoint values (0x00d800 ~ 0x00dfff)",
        ArgumentOutOfRange_InvalidHighSurrogate = "Invalid high surrogate. A valid high surrogate character is between 0xd800 and 0xdbff, inclusive",
        ArgumentOutOfRange_InvalidLowSurrogate = "Invalid low surrogate. A valid low surrogate character is between 0xdc00 and 0xdfff, inclusive",
        BitLibraryNotFound = "A bit library was not found",
        Argument_NotChar = "Argument is not a System.Char",
        Argument_NotChar2 = "Object is not System.Char or native string/char type",
        Argument_NotString = "Argument was not a string",
        Argument_NotString2 = "Object is not System.String or native string type",
        Argument_StringLengthNotOne = "Argument's length was not one (1)",
        Class_CannotCreateStaticClass = "Cannot create an instance of a static class",
        Argument_CultureNotSupported = "Culture is not supported",
        Argument_MustBeByte = "Argument(s) must be of System.Byte",
        Argument_ByteOverflow = "Argument is either larger or smaller than the allowed range for a byte (0-255)",
        Console_NoInputStream = "No input stream found for System.Console",
        Math_DomainError = "Domain Error",
        Math_CantComputeLog = "Can't compute Log",
        BitLibraryFunctionNotFound = "Bit function %s not found!",
        InvalidCast_ToIConvertible = "Cannot cast type to System.IConvertible",
        InvalidCast_ToIConvertible2 = "Cannot cast type %s to System.IConvertible",
        NotClrClass = "Not a CLR object",
        NotClrClass2 = "Native type \"%s\" is not a valid CLR object",
        Format_BadBase64CharArrayLength = "Bad Base64 char array length",
        PlatformNotSupported = "This platform is not supported",
        PlatformNotSupported2 = "Your platform, %s, is not supported",
        PlatformNotSupported3 = "Your platform, %s, does not support function %s",
        PlatformNotSupported4 = "This platform does not support function %s",
        Argument_NilGeneric = "Value cannot be nil",
        Argument_Nil = "Argument '%s' cannot be nil",
        Path_InvalidPath = "Invalid path",
    },

    [""] = {

    }
}

-- Set a __index field.
-- Currently, it is in American English. Maybe later, I'll change it
for k, v in pairs(System.LocalizedMessages) do
    setmetatable(v, { __index = function(t, k) return "Unknown Message. ID: " .. tostring(k) end })
end
setmetatable(System.LocalizedMessages, { __index = function(t, k) return "Unknown language" .. k end })
