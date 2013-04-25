if did_filetype() " filetype already set..
    finish " stop checking
endif

if getline(1) =~ '^#!/usr/bin/env node'
    setfiletype javascript
endif
