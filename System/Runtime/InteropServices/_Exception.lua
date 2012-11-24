System.Runtime = System.Runtime or { }
System.Runtime.InteropServices = System.Runtime.InteropServices or { }

System.Runtime.InteropServices._Exception = { 
    ClassName = "_Exception",
    Namespace = "System.Runtime.InteropServices",
    
    Message = "",
    StackTrace = "",
    HelpLink = "",
    Source = "",
    InnerException = nil,
    TargetSite = nil,
    GetBaseException = nil, -- function
}

setmetatable(System.Runtime.InteropServices._Exception, { __index = System.Interface })
