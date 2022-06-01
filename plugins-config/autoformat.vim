"" Autoformat python files with black, on save
autocmd BufWritePre *.py execute ':Black'

let g:prettier#autoformat = 0
autocmd BufWritePre *.mjs,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.mdx,*.vue,*.yaml,*.html*.yml PrettierAsync
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.php call OrganizeAndFormatWithPrettier()
autocmd BufWritePre *.frag,*.vert Neoformat

function! OrganizeAndFormatWithPrettier()
  call CocAction('runCommand', 'editor.action.organizeImport')
  Prettier
endfunction

command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
