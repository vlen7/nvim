function lv#add_tags(tag,args)
        let path = expand('%p')
        execute 'normal va{^['
        let range = line("'<").",".line("'>")
        call system('gomodifytags -add-tags '.a:tag.' -file '.path.' -line '.range.' -w '.a:args)
        e
endfunction

function lv#remove_tags(tag,args)
        let path = expand('%p')
        execute 'normal va{^['
        let range = line("'<").",".line("'>")
        call system('gomodifytags -remove-tags '.a:tag.' -file '.path.' -line '.range.' -w '.a:args)
        e
endfunction

" gomodifytags
function lv#gomodifytags(s,e,c,cmd,tag,...)
        let path = expand('%p')
        let v = winsaveview()
        if a:c < 0
                execute 'normal va{^['
                let range = line("'<").",".line("'>")
        else
                let range = a:s.",".a:e
        end
        call system('gomodifytags '.a:cmd.' '.a:tag.' -file '.path.' -line '.range.' -w '.join(a:000, ' '))
        e
        call winrestview(v)
endfunction
