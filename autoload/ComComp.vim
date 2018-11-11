function! s:IsArgumentComplete(argument, argseperator)
    "determine if given argument has been completed by checking, that the last
    "character matches argument seperator
    return a:argument[-1:] is# a:argseperator
endfunction

function! s:GetArguments(cmdline, argseperator)
    "return all arguments except the command name (first argument)
    return split(a:cmdline, a:argseperator, 1)[1:]
endfunction

function! s:ExtractArgLead(arguments, argseperator)
    if len(a:arguments) > 0 && !s:IsArgumentComplete(a:arguments[-1], a:argseperator)
        return remove(a:arguments, -1)
    endif
    return ''
endfunction

function! ComComp#Complete(cmdline, compfuncs, argseperator)
    let l:arguments = s:GetArguments(a:cmdline, a:argseperator)
    let l:arglead = s:ExtractArgLead(l:arguments, a:argseperator)
    let l:argcount = len(l:arguments)
    let l:completions = []

    if (l:argcount >= len(a:compfuncs))
        return l:completions
    endif

    let l:CompletionFunction = get(a:compfuncs, l:argcount)
    return call(l:CompletionFunction, [l:arguments, l:arglead, a:argseperator])
endfunction
