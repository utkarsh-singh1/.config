--[[

██████╗ ██╗   ██╗███████╗███████╗███████╗██████╗ ██╗     ██╗███╗   ██╗███████╗
██╔══██╗██║   ██║██╔════╝██╔════╝██╔════╝██╔══██╗██║     ██║████╗  ██║██╔════╝
██████╔╝██║   ██║█████╗  █████╗  █████╗  ██████╔╝██║     ██║██╔██╗ ██║█████╗  
██╔══██╗██║   ██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══██╗██║     ██║██║╚██╗██║██╔══╝  
██████╔╝╚██████╔╝██║     ██║     ███████╗██║  ██║███████╗██║██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝
                                                                              

--]]


-- bufferline
require("bufferline").setup{
    options = {
        diagnostics =  "coc",
        indicator = {
                icon =  '▎', 
                style = 'icon',
            },
        buffer_close_icon = '✖ ',
        modified_icon = '✎',
        close_icon = '✖ ',
        left_trunc_marker = '',
        right_trunc_marker = '',
        offsets = {
            {
               filetype = "NvimTree",
               text = "File Explorer 🗂",
               highlight = "Directory",
               sperator = true
            }
        },

    }
}
