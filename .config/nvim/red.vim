" Replace mode
let s:R1 = [ '#141413' , '#911d29'  , 232 , 203 ]
let s:R2 = [ '#911d29' , '#32322F'  , 203 , 238 ]
let s:R3 = [ '#911d29' , '#242424'  , 203 , 235 ]
let s:R4 = [ '#911d29' , 203 ]

" Paste mode
let s:PA = [ '#94E42C' , 47 ]

" Info modified
let s:IM = [ '#40403C' , 238 ]

" Inactive mode
let s:IA = [ '#767676' , s:R3[1] , 243 , s:R3[3] , '' ]

let g:airline#themes#red#palette = {}

let g:airline#themes#red#palette.accents = {
      \ 'red': [ '#5D284F' , '' , 203 , '' , '' ],
      \ }

let g:airline#themes#red#palette.normal = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#red#palette.normal_modified = {
    \ 'airline_a': [ s:R1[0] , s:R4[0] , s:R1[2] , s:R4[1] , ''     ] ,
    \ 'airline_b': [ s:R4[0] , s:IM[0] , s:R4[1] , s:IM[1] , ''     ] ,
    \ 'airline_c': [ s:R4[0] , s:R3[1] , s:R4[1] , s:R3[3] , ''     ] }


let g:airline#themes#red#palette.insert = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#red#palette.insert_modified = {
    \ 'airline_a': [ s:R1[0] , s:R4[0] , s:R1[2] , s:R4[1] , ''     ] ,
    \ 'airline_b': [ s:R4[0] , s:IM[0] , s:R4[1] , s:IM[1] , ''     ] ,
    \ 'airline_c': [ s:R4[0] , s:R3[1] , s:R4[1] , s:R3[3] , ''     ] }


let g:airline#themes#red#palette.visual = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#red#palette.visual_modified = {
    \ 'airline_a': [ s:R1[0] , s:R4[0] , s:R1[2] , s:R4[1] , ''     ] ,
    \ 'airline_b': [ s:R4[0] , s:IM[0] , s:R4[1] , s:IM[1] , ''     ] ,
    \ 'airline_c': [ s:R4[0] , s:R3[1] , s:R4[1] , s:R3[3] , ''     ] }


let g:airline#themes#red#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#red#palette.replace_modified = {
    \ 'airline_a': [ s:R1[0] , s:R4[0] , s:R1[2] , s:R4[1] , ''     ] ,
    \ 'airline_b': [ s:R4[0] , s:IM[0] , s:R4[1] , s:IM[1] , ''     ] ,
    \ 'airline_c': [ s:R4[0] , s:R3[1] , s:R4[1] , s:R3[3] , ''     ] }


let g:airline#themes#red#palette.insert_paste = {
    \ 'airline_a': [ s:R1[0] , s:PA[0] , s:R1[2] , s:PA[1] , ''     ] ,
    \ 'airline_b': [ s:PA[0] , s:IM[0] , s:PA[1] , s:IM[1] , ''     ] ,
    \ 'airline_c': [ s:PA[0] , s:R3[1] , s:PA[1] , s:R3[3] , ''     ] }


let g:airline#themes#red#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#red#palette.inactive_modified = {
    \ 'airline_c': [ s:R4[0] , ''      , s:R4[1] , ''      , ''     ] }

" Warnings
let s:WI = [ '#282C34', '#994646', 0, 124 ]
let g:airline#themes#red#palette.normal.airline_warning = [
      \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
      \ ]

let g:airline#themes#red#palette.normal_modified.airline_warning =
    \ g:airline#themes#red#palette.normal.airline_warning

let g:airline#themes#red#palette.insert.airline_warning =
    \ g:airline#themes#red#palette.normal.airline_warning

let g:airline#themes#red#palette.insert_modified.airline_warning =
    \ g:airline#themes#red#palette.normal.airline_warning

let g:airline#themes#red#palette.visual.airline_warning =
    \ g:airline#themes#red#palette.normal.airline_warning

let g:airline#themes#red#palette.visual_modified.airline_warning =
    \ g:airline#themes#red#palette.normal.airline_warning

let g:airline#themes#red#palette.replace.airline_warning =
    \ g:airline#themes#red#palette.normal.airline_warning

let g:airline#themes#red#palette.replace_modified.airline_warning =
    \ g:airline#themes#red#palette.normal.airline_warning

" Errors
let s:ER = [ '#282C34', '#E06C75', 0, 88 ]
let g:airline#themes#red#palette.normal.airline_error = [
      \ s:ER[0], s:ER[1], s:ER[2], s:ER[3]
      \ ]

let g:airline#themes#red#palette.normal_modified.airline_error =
    \ g:airline#themes#red#palette.normal.airline_error

let g:airline#themes#red#palette.insert.airline_error =
    \ g:airline#themes#red#palette.normal.airline_error

let g:airline#themes#red#palette.insert_modified.airline_error =
    \ g:airline#themes#red#palette.normal.airline_error

let g:airline#themes#red#palette.visual.airline_error =
    \ g:airline#themes#red#palette.normal.airline_error

let g:airline#themes#red#palette.visual_modified.airline_error =
    \ g:airline#themes#red#palette.normal.airline_error

let g:airline#themes#red#palette.replace.airline_error =
    \ g:airline#themes#red#palette.normal.airline_error

let g:airline#themes#red#palette.replace_modified.airline_error =
    \ g:airline#themes#red#palette.normal.airline_error

