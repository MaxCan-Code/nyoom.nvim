;; *quickref* *stdlib* *12.7*

(let [o vim.opt
      au (lambda [event pattern callback]
           (vim.api.nvim_create_autocmd event {: pattern : callback}))
      nn (partial vim.keymap.set :n)
      nl #(nn (.. :<leader> $1) $2)]
  (o.pa:append "**") ; *'pa'* *file-searching*
  (au :BufWinEnter "*" #(do
                          (set o.nu true)
                          (set o.rnu true)))
  (set vim.g.netrw_bufsettings "noma nomod nu nobl nowrap ro rnu") ; *netrw-P19*
  ;
  (o.cpo:append "$") ; *cpo-$*
  (set o.wim "longest:full")
  (set o.kp ":help")
  (set o.ic true)
  (set o.scs true)
  (set o.cc :80)
  (set o.sm true)
  (o.dip:append "linematch:60")
  ;
  (nl :w :<cmd>up<cr>)
  (nn :<C-w>Q :<cmd>qa<cr>)
  (nl :v "<cmd>cd ~/.config/nvim<cr>")
  (nl "." "<cmd>cd ~/.dotfiles<cr>")
  (nl :P "<cmd>cd ~/.local/share/nvim/site/pack<cr>")
  (nl :p "<cmd>cd ~/vc/projects<cr>")
  ;
  (set o.udf true)
  (set o.hls false)
  (set o.ls 3)
  (set o.wbr "%=%n:%y %t %m%=")
  (vim.api.nvim_set_hl 0 :WinSeparator {})
  (vim.api.nvim_set_hl 0 :Normal {})
  (set o.list true)
  (set o.spk :screen)
  (o.dip:append "linematch:60")
  (au :TextYankPost "*" #(vim.highlight.on_yank))
  ;
  (nn :U :<c-r>)
  (nn :c-r :U)
  ;
  (nn :S "") ; cc
  (nn :s "") ; cl
  (nn :O "") ; jA<cr>
  (nn :o "q:") ; A<cr>
  (nn :X "") ; dh
  (nn :x "") ; dl
  (nn "?" :q/) ; N
  (nn :w "") ; https://stackoverflow.com/a/23489147
  (nn :e "")
  (nn :b "")
  (nn :jj "")
  (nn :kk ""))

(let [{: github : git : make-pact} (require :pact)
      nn (partial vim.keymap.set :n)
      ;; nl #(nn (.. :<leader> $1) $2 {:desc $2})
      nl (lambda [ldr rhs desc]
           (nn (.. :<leader> ldr) rhs {: desc}))]
  (make-pact (github :rktjmp/hotpot.nvim {:branch :nightly})
             (github :rktjmp/pact.nvim {:branch :master})
             (github :nvim-treesitter/nvim-treesitter {:branch :master})
             (github :nvim-treesitter/nvim-treesitter-refactor
                     {:branch :master})
             (github :nvim-treesitter/nvim-treesitter-textobjects
                     {:branch :master})
             (github :nvim-lua/plenary.nvim {:branch :master})
             (github :nvim-telescope/telescope.nvim {:branch :master})
             (github :ziontee113/syntax-tree-surfer {:branch :master})
             (github :mfussenegger/nvim-dap {:branch :master})
             (github :williamboman/mason.nvim {:branch :main})
             (github :smoka7/hop.nvim {:branch :master})
             (github :folke/which-key.nvim {:branch :main})
             (github :jose-elias-alvarez/null-ls.nvim {:branch :main}))
  ;; pact
  (nl :k #(: (require :pact) :open {}) :Pact)
  ;
  ;; nvim-treesitter
  ((. (require :nvim-treesitter.configs) :setup) {:highlight {:enable true}
                                                  :indent {:enable true}
                                                  :refactor {:highlight_definitions {:enable true}}
                                                  :textobjects {:select {:enable true
                                                                         :lookahead true}
                                                                :swap {:enable true}
                                                                :move {:enable true}
                                                                :lsp_interop {:enable true}}})
  (set vim.o.fdm :expr)
  (set vim.o.fde "nvim_treesitter#foldexpr()")
  ;
  ;; telescope
  (let [{: builtin : git_files : help_tags : resume : buffers : jumplist} (require :telescope.builtin)]
    ((. (require :telescope) :setup) {:defaults {:layout_config {:preview_cutoff -1
                                                                 :horizontal {:preview_width 0.6}}
                                                 :layout_strategy :flex}})
    (nl :ff builtin :builtin)
    (nl :fg git_files :git_files)
    (nl :fh help_tags :help_tags)
    (nl :fr resume :resume)
    (nl :fb buffers :buffers)
    (nl :fj jumplist :jumplist))
  ;
  ;; hop
  (let [{: setup : hint_words} (require :hop)]
    (setup {})
    ;; (nn :s #((. (require :hop-treesitter) :hint_nodes) {}))
    (nn :s #(hint_words {:multi_windows true}))
    (nn :gs #(hint_words {:multi_windows true}))
    (vim.keymap.set :o :x #(hint_words {:multi_windows true})))
  ;
  ;; choosewin
  (set vim.g.choosewin_overlay_enable 1)
  (nn :<C-w><C-m> "<Plug>(choosewin)")
  (nn :<C-w>m "<Plug>(choosewin)")
  ;
  ;; which-key
  ((. (require :which-key) :setup) {:plugins {:spelling {:enabled true}}})
  ;
  ;; null-ls
  (let [{: setup : builtins} (require :null-ls)]
    (setup {:sources [(. builtins :formatting :fnlfmt)
                      (. builtins :completion :spell)]}))
  (nl :F vim.lsp.buf.format :Format)
  ;
  ;; mason
  ((. (require :mason) :setup) {}))

[{:elkowar/antifennel-nvim :b}
 {"https://git.sr.ht/~technomancy/antifennel" :b :run :remake}
 {:gpanders/nvim-moonwalk :b}
 {:stevearc/aerial.nvim :b}
 {:stevearc/qf_helper.nvim :b}
 {:weilbith/nvim-lsp-smag :b}
 {:VonHeikemen/lsp-zero.nvim :b}
 {:weilbith/nvim-code-action-menu :b}
 {:weilbith/nvim-floating-tag-preview :b}
 {:simrat39/symbols-outline.nvim :b}
 {:ThePrimeagen/vim-apm :b}
 {:danth/pathfinder.vim :b}
 {:mrever/Vython :b}]
