<div align=center>
<h1>hasten.nvim</h1>
<




/div>




https://github.com/genzyy/hasten.nvim/assets/48408336/c4e4c736-e937-4d1f-96bb-13a4567914ef


Quickly switch your open buffers with custom keybinds on fly.

## About
I used to use buffer lines in nvim and while working on big projects, I wanted to switch buffers quickly without iterating through all the open buffers or using mouse (using mouse with neovim? AINT NO WAY!). I looked at [harpoon](https://github.com/ThePrimeagen/harpoon) but I wanted something a bit more simple and having a feature to change/add keymaps to switch buffers on fly and so I made Hasten. It made  workflow better and more organized, switching buffers is much easier for me now.

## Usage

- [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
return {
"genzyy/hasten.nvim",
   dependencies = {
        "nvim-lua/plenary.nvim",
    },
  config = function()
    require("hasten").setup({})
  end
}
```

- [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
  use {
    "genzy/hasten.nvim", requires = { "nvim-lua/plenary.nvim" },
    config = function() require('hasten').setup() end
  }
```

## Commands

- `HastenMapBuff <sub_key>`: Map currently active buffer to passed sub key. Note that the sub_key argument cannot be more than 1 key for now.

- `HastenViewMaps`: View all Hasten buffer maps.

- `HastenClearMaps`: Clear all hasten maps and if any default keymaps were overwritten, restore them. Also clears predefined maps if they are mapped to any active buffer.

- `HastenUsePredefinedMaps`: Use predefined maps from config and map current buffer to first mapping in the provided list. As you map the buffers, the maps are used and are removed from the list of available pre defined user maps.


### My Config
```lua
return {
  "genzyy/hasten.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("hasten").setup({
      predefined_keymaps = {
        "<C-x>",
        "<C-c>",
      }
    })

    vim.keymap.set("n", "<leader>h", ":HastenUsePredefinedMaps<CR>", { silent = true })
    vim.keymap.set("n", "<leader>g", ":HastenViewMaps<CR>", { silent = true })
  end,
}
```


### Note
This plugin is still a WIP, I have a list of things that I want to add but not sure how to prioritize them and how much time I need to implement them. Will add a TODO list here.

### Alternatives

- [harpoon.nvim](https://github.com/ThePrimeagen/harpoon)
