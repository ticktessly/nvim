-- Source - https://stackoverflow.com/a/73365602
-- Posted by lcheylus, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-09-18, License - CC BY-SA 4.0

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.hl.hl_op({ higroup = "IncSearch", timeout = 150 })
	end,
})
