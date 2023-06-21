local comment_status, comment = pcall(require, "Comment")
if comment_status then
comment.setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
})
end

