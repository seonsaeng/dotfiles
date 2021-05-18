setlocal fdm=syntax
setlocal cc=81
setlocal et ts=3 sts=3 sw=3

" Temporary Fix, for Algo lab
noremap <silent> <F9> :!g++ -std=c++17 -D_FORTIFY_SOURCE=2 -Wshadow -Wall -Wextra -Wpedantic -Wlogical-op -Wformat=2 -Wfloat-equal -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -o %< % -Og -g -fsanitize=address,undefined,float-divide-by-zero,float-cast-overflow -fno-sanitize-recover=all -fstack-protector-all -D_GLIBCXX_DEBUG -D_GLIBCXX_ASSERTIONS -D_GLIBCXX_DEBUG_PEDANTIC -DLOCAL<CR>

noremap <silent> <F8> :w<CR> :!g++ -std=c++17 -Wshadow -Wall -Wextra -o %< % -O2 -Wno-unused-result -DLOCAL<CR>
