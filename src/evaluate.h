#ifndef EVALUATE_H
#define EVALUATE_H

#include "types.h"

// Default NNUE network file the engine tries to load at startup if no UCI
#define DefaultEvalFile "nn-309ffdbd6879.nnue"

enum { Tempo = 28 };

#ifdef NNUE
enum { EVAL_HYBRID, EVAL_PURE, EVAL_CLASSICAL };
#ifndef NNUE_PURE
extern int useNNUE;
#else
#define useNNUE EVAL_PURE
#endif
#endif

Value evaluate(const Position *pos);

#endif
