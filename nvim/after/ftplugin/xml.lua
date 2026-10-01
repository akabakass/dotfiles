-- L'indentexpr de treesitter ne redescend pas d'un niveau en sortie de bloc
-- (</div> suivi d'un o). On prend le script natif de vim.
-- Mais XmlIndentGet s'appuie sur synID(), muet depuis que la coloration passe
-- par treesitter seul : son calcul tombe alors dans la branche
-- "non-xml tag content" qui recopie betement l'indentation precedente.
-- On recharge donc la syntaxe legacy uniquement pour alimenter synID().
-- Elle ne colore rien : les extmarks de treesitter sont prioritaires.
-- (C'est ce que faisait additional_vim_regex_highlighting avant la migration.)
vim.b.did_indent = nil
vim.bo.indentexpr = ""
vim.cmd("runtime! indent/xml.vim")
