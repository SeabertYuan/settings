let s:base02 = [ '#16161d', 236 ] "darkest
let s:base01 = [ '1f1f28', 239 ]
let s:base00 = [ '2a2a37', 242 ]
let s:base0 = [ '#363646', 244 ]
let s:base1 = [ '#54546d', 246 ]
let s:base2 = [ '#938aa9', 248 ] "lightest

let s:roninYellow = [ '#dca561', 214 ]  "warning
let s:surimiOrange = [ '#ffA066', 209 ]
let s:autumnRed = [ '#c34043', 203 ]
let s:samuraiRed = [ '#d27e99', 196 ]   "error
let s:waveAqua = [ '#6a9589', 79 ]
let s:autumnGreen = [ '#76946a', 77 ]
let s:fujiWhite = [ '#dcd7ba', 253 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:waveAqua ], [ s:fujiWhite, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base02, s:autumnGreen ], [ s:fujiWhite, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:autumnRed ], [ s:fujiWhite, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:surimiOrange ], [ s:fujiWhite, s:base01 ] ]
let s:p.normal.middle = [ [ s:base0, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left = [ [ s:fujiWhite, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:fujiWhite, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base1 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:samuraiRed, s:base02 ] ]
let s:p.normal.warning = [ [ s:roninYellow, s:base01 ] ]

let g:lightline#colorscheme#kanagawa#palette = lightline#colorscheme#flatten(s:p)
