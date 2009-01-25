

if version < 600
  so <sfile>:p:h/html.vim
  syn include @sqlTop     <sfile>:p:h/sql.vim
  syn include @javascriptTop <sfile>:p:h/javascript.vim
else
  syn include @javascriptTop syntax/javascript.vim
  unlet b:current_syntax

  syn include @sqlTop syntax/sql.vim
  unlet b:current_syntax

  syn include @htmlTop syntax/html.vim
  "runtime! syntax/html.vim
  unlet b:current_syntax

endif
