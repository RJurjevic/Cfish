/*
  Stockfish, a UCI chess playing engine derived from Glaurung 2.1
  Copyright (C) 2004-2008 Tord Romstad (Glaurung author)
  Copyright (C) 2008-2015 Marco Costalba, Joona Kiiski, Tord Romstad
  Copyright (C) 2015-2016 Marco Costalba, Joona Kiiski, Gary Linscott, Tord Romstad

  Stockfish is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Stockfish is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>

#include "bitboard.h"
#include "endgame.h"
#include "pawns.h"
#include "polybook.h"
#include "position.h"
#include "search.h"
#include "thread.h"
#include "tt.h"
#include "uci.h"
#include "tbprobe.h"

/*
  V 12.0
    - Cfish 12 modified so to use flipped HalfKP 256x2-32-32-1 NNUE.
    - Used nn-4e52da8f037a.nnue NNUE aka nn-v0f000007015.nnue.

  V 12.1
    - Introduced Stockfish 15 search Step 7 Razoring.
    - Introduced Stockfish 15 bestMoveCount and used in search Step 17 Late moves reduction / extension (LMR)
    - In search Step 17 Late moves reduction / extension (LMR) removed decreasing reduction if the ttHit running average is large.
    - In search Step 17 Late moves reduction / extension (LMR) removed increasing reduction at root and non-PV nodes when the best move does not change frequently.
    - In search Step 17 Late moves reduction / extension (LMR) as in Stockfish 15 killer moves used to decide if to increase reduction for cut nodes.
    - In search Step 17 Late moves reduction / extension (LMR) as in Stockfish 15 decreased reduction at PvNodes if bestvalue is vastly different from static evaluation.

  V 12.2
    - Used nn-85eb44d29a98.nnue NNUE aka nn-v0f000008045.nnue.
    - In search Step 8 Futility pruning child node as in Stockfish 15 futility margin changed based on statScore.
    - Quiet moves sort scoring updated to take into account if the piece is threatened as in Stockfish 15.
    - In search Step 7 Razoring fixed a bug where we would call incorrect qsearch function if the move was non checking.

  V 12.3
    - Used nn-268f1649a50c.nnue NNUE aka nn-v0f000008061.nnue.
    - In search Step 6 Static evaluation of the position used Stockfish 16 dev static evaluation difference to improve quiet move ordering.
    - In search Step 7 Razoring razoring implemented similarly as in Stockfish 16 dev.
    - In search Step 11 Internal iterative deepening implemented internal iterative deepening similar like in Cfish 9.
    - In search Step 17 Late moves reduction / extension (LMR) used criteria for LMR similar as in later Stockfish.
    - In search Step 17 Late moves reduction / extension (LMR) removed decreasing reduction if ttMove is a capture.
    - In search Step 17 Late moves reduction / extension (LMR) used criteria for capping LMR depth like in later Stockfish.

  V 12.4
    - Used nn-62fa8067463a.nnue NNUE aka nn-v0f000009011.nnue.
    - Updated scoring of quiet moves.
    - In search Step 11 Internal iterative deepening implemented internal iterative deepening as in Cfish 9.

  V 12.5
    - Used nn-017411c866a4.nnue NNUE aka nn-v0f000009305.nnue.
    - Updated Makefile to download nets from www.jurjevic.org.uk.

  V 12.6
    - Used nn-7f1489a0278c.nnue NNUE aka nn-v0f000011203.nnue.
    - In search Step 11, adjusted the criteria for when to apply internal iterative deepening.

  V 12.7
    - Used nn-706a9fe25219.nnue NNUE aka nn-v0f000011601.nnue.

  V 12.8
    - Used nn-1590a1b77c10.nnue NNUE aka nn-v0f000011800.nnue.
    - Updated quiet move sorting to factor in whether the move results in a check, as in later Stockfish versions.
    - In search improving flag implemented as in Stockfish 17.1.
    - In search Step 15 Extensions used singular extension search depth criteria like in Stockfish 17.1.
    - In search Step 17 Late moves reduction / extension (LMR) increased reduction if ttMove is a capture but the current move is not as in Stockfish 17.1.
*/

int main(int argc, char **argv)
{
  print_engine_info(false);

  psqt_init();
  bitboards_init();
  zob_init();
  bitbases_init();
#ifndef NNUE_PURE
  endgames_init();
#endif
  threads_init();
  options_init();
  search_clear();

  uci_loop(argc, argv);

  threads_exit();
  TB_free();
  options_free();
  tt_free();
  pb_free();
  #ifdef NNUE
  nnue_free();
  #endif

  return 0;
}
