" Vim syntax file
" Language:	    Perl / Jifty Web Frame Application
" Maintainer:	  Lin Yo-An  <cornelius.howl+vim@gmail.com> 
" Last Change:	2009 Jan 25
"
" Install:
" put jifty.vim to ~/.vim/after/syntax/perl/jifty.vim
" append following lines to ~/.vim/syntax/perl.vim
" ===============================
" if version < 600
"   so <sfile>:p:h/html.vim
"   syn include @sqlTop     <sfile>:p:h/sql.vim
"   syn include @javascriptTop <sfile>:p:h/javascript.vim
" else
"   syn include @javascriptTop syntax/javascript.vim
"   syn include @sqlTop syntax/sql.vim
"   runtime! syntax/html.vim
"   unlet b:current_syntax
" endif
" ================================


syn keyword     jfmethods  current_user_can before_create after_create take_action

" template declare
syn keyword     jftdtag           div span cell h1 h2 h3 h4 h5 h6 pre hyperlink form table row th thead tfoot script p label input ul li strong img fieldset
syn keyword     jftdfunction      show outs outs_raw with get set page content form_submit 
syn keyword     jftdfunction      out url serial setup_session current_user handle_request form new_action new_action_from_request failed_actions succeeded_actions redirect_required
syn keyword     jftdfunction      webservices_redirect redirect caller tangent link render_param render_region render_messages render_success_messages render_error_messages query_string escape escape_uri navigation
syn keyword     jftdfunction      page_navigation include_css add_css include_javascript add_javascript remove_javascript add_external_javascript
syn keyword     jftdfunction      clear_state_variables get_region region replace_current_region current_region qualified_region add_action register_action has_action start submit

syn cluster     jifty             contains=jftdtag,jftdfunction


syn match       jfscolname  "\v((param|column)\_[ \n]*)@<=\w+" contained
syn keyword     jfscol      param column      nextgroup=jfscolname contained
syn keyword     jfspropertybe     is are      nextgroup=jfsproperty contained
syn keyword     jfsproperty   type refers_to render_as valid hints default since label immutable mandatory
            \   nextgroup=jfspropis contained

if exists("jifty_fold_schema") 
  syn region jfms start=+schema[ \n]*{+ end=+}[\n ]*;+ contains=jfscolumn,perlComment fold
else
  syn region jfms start=+schema[ \n]*{+ end=+}[\n ]*;+ contains=jfscolumn,perlComment
endif


if exists("jifty_fold_schema_column")
  syn region jfscolumn start=+^\s*\(param\|column\)\>+  end=+;+ contained contains=jfspropertybe,jfsproperty,jfscol,jfscolname,
            \ perlComment,perlString,perlFunction,perlFloat,perlNumber,perlSpecialString,perlStringUnexpanded 
            \ fold
else
  syn region jfscolumn start=+^\s*\(param\|column\)\>+  end=+;+ contained contains=jfspropertybe,jfsproperty,jfscol,jfscolname,
            \ perlComment,perlString,perlFunction,perlFloat,perlNumber,perlSpecialString,perlStringUnexpanded
endif

" let template and div fold
if exists("jifty_fold_template")
  syn region      jftemplate        start=+^\(private\s\+\)\=template+ end=+^};+ transparent fold keepend
endif

if exists("jifty_fold_dispatcher")
  syn region      jfdispatcher        start=+^\(before\|on\)\s\++ end=+^};+ transparent fold
endif

if exists("jifty_fold_tags")
  syn region      jftags           start="^\z(\s*\)\<\(div\|table\|row\|form\|script\)\>\s*{" end="^\z1};\=" transparent fold keepend
endif

"syn region jfdispatcher  
" syn region jfembjs    start=+\(<<\)\@<=JS\z(.*\)$+     end=+^JS\z1$+    contains=@javascriptTop
" syn region jfembsql   start=+\(<<\)\@<=SQL\z(.*\)$+    end=+^SQL\z1$+   contains=@sqlTop
" syn region jfembhtml  start=+\(<<\)\@<=HTML\z(.*\)$+   end=+^HTML\z1$+  contains=@htmlTop

" FIXME:  we can't use lookforward because the perlHereDoc will match first,
" so we create another inner block contained by jfembhtml
syn region jfembhtmlblock start=+\(<<\)\@<=HTML+  end=+^\(HTML\)\@=+ contained contains=@htmlTop

syn region jfembjs    start=+<<JS\z(.*\)$+     end=+^JS\z1$+    contains=@javascriptTop
syn region jfembsql   start=+<<SQL\z(.*\)$+    end=+^SQL\z1$+   contains=@sqlTop
syn region jfembhtml  start=+<<HTML\z(.*\)$+   end=+^HTML\z1$+  contains=jfembhtmlblock
"syn region jfembhtml  start=+HTML\z(.*\)$+   end=+^HTML\z1$+  contains=@htmlTop

hi link jfscol        perlStatement
hi link jftdtag       perlStatement
hi link jftdfunction  perlMethod
hi link jfmethods     perlMethod
hi link jfscolname    perlType
hi link jfspropertybe perlIdentifier
hi link jfsproperty   perlIdentifier
