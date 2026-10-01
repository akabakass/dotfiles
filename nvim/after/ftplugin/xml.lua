-- Le module indent de nvim-treesitter est experimental et se trompe sur
-- l'imbrication XML (un <record> ne cree pas de niveau). Le script natif
-- de vim fait le bon travail. after/ftplugin passe APRES treesitter.
vim.b.did_indent = nil
vim.bo.indentexpr = ""
vim.cmd("runtime! indent/xml.vim")
