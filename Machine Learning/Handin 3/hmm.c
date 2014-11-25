#include <stdio.h>
#include <stdlib.h>

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

#define STATE_NONCODE 0
#define STATE_STARTCODAN 1
#define STATE_CODING STATE_STARTCODAN+4*4*4*3
#define STATE_END STATE_CODING+3

typedef struct HMM {
	double *trans, *init, *emit;
	int *emitCounter, *transCounter;
	int NStates, NLetters;
} HMM;

HMM* makeHMM(int NStates, int NLetters)
{
	HMM* hmm = malloc(sizeof(HMM));
	hmm->trans = malloc(sizeof(double)*NStates*NStates);
	hmm->init = malloc(sizeof(double)*NStates);
	hmm->emit = malloc(sizeof(double)*NStates*NLetters);
	hmm->emitCounter = calloc(NStates, sizeof(int));
	hmm->transCounter = calloc(NStates, sizeof(int));
	hmm->NStates = NStates;
	hmm->NLetters = NLetters;
	return hmm;
}


void setTransition(HMM* hmm, int from, int to, double val) 
{
	*(hmm->trans + (from*hmm->NStates) + to) = val;
	hmm->transCounter[from]++;
}
double getTransition(HMM* hmm, int from, int to) 
{
	return *(hmm->trans + (from*hmm->NStates) + to);
}
void setEmission(HMM* hmm, int state, int observation, double val) 
{
	*(hmm->emit + (state*hmm->NLetters) + observation) = val;
	hmm->emitCounter[state]++;
}
double getEmission(HMM* hmm, int state, int observation) 
{
	return *(hmm->emit + (state*hmm->NLetters) + observation);
}


int genCodeToInt(char c)
{
	switch (c) {
		case 'A':
			return 0;
		case 'C':
			return 1;
		case 'G':
			return 2;
		case 'T':
			return 3;
	}
	return -1;
}

void train(HMM* hmm, FILE* annotation, FILE* genome)
{
	int isStartCodan = 1;
	
	/* ignore first line */
	while (getc(annotation) != '\n');
	while (getc(genome) != '\n');
	
	/* train model reading 1 charactor at a time */
	char a, g, s1, s2, s3;
	int state, nextState;
	do {
		a = getc(annotation);
		g = getc(genome);
		
		if (a == 'C') {
			
			/* are we at start codan */
			if (isStartCodan == 1) {
				
				isStartCodan = 0;
				
				s1 = g;
				s2 = getc(genome);
				s3 = getc(genome);
				
				/* find state (encode as a base 4 number)*/
				state = 1 +
					(genCodeToInt(s1)*4*4+
					genCodeToInt(s2)*4+
					genCodeToInt(s3))*3;
				
				
				/* set missions to 1 */
				setEmission(hmm, state, genCodeToInt(s1), getEmission(hmm, state, genCodeToInt(s1))+1.0);
				setEmission(hmm, state, genCodeToInt(s3), getEmission(hmm, state, genCodeToInt(s2))+1.0);
				setEmission(hmm, state, genCodeToInt(s3), getEmission(hmm, state, genCodeToInt(s3))+1.0);
				
				/* here we should count */
				
				
				getc(annotation);
				getc(annotation);	
				
				state = STATE_CODING;
				
			} else { /* we are inside a codan */

				/* find next state */
				nextState = state+1;
				if (nextState >= STATE_END) {
					nextState = STATE_CODING;				
				}			

				/* count emission */
				double e = getEmission(hmm, state, genCodeToInt(g));
				setEmission(hmm, state, genCodeToInt(g), e+1.0);

				/* count transistion */
				setTransition(hmm, state, nextState, getTransition(hmm, state, nextState)+1.0);
				state = nextState;

			
			}
				
		} else {
			isStartCodan = 1;
		}
		
	} while (a != EOF && g != EOF);

	/* average the countings */
	int i,j;
	for (i = 0; i < hmm->NStates; i++) {
		for (j = 0; j < hmm->NStates; j++) {
			double t = getTransition(hmm, i, j);
			if (t > 0.0) {
				printf("%d -> %d %0.2lf\n", i, j, t);
			}
		}
	}
	for (i = 0; i < hmm->NStates; i++) {
		for (j = 0; j < hmm->NLetters; j++) {
			double t = getEmission(hmm, i, j);
			if (t > 0.0 && hmm->emitCounter[i] > 0) {
				setEmission(hmm, i, j, t/((double)hmm->emitCounter[i]));
			}
		}
	}
}

void printHMM(HMM* hmm) 
{
	int i,j;
	printf("Transitions\n");
	for (i = 0; i < hmm->NStates; i++) {
		for (j = 0; j < hmm->NStates; j++) {
			double t = getTransition(hmm, i, j);
			if (t > 0.0) {
				printf("%d -> %d %0.2lf\n", i, j, t);
			}
		}
	}
	
	printf("Emissions\n");
	for (i = 0; i < hmm->NStates; i++) {
		for (j = 0; j < hmm->NLetters; j++) {
			double t = getEmission(hmm, i, j);
			if (t > 0.0) {
				printf("%d -> %d %0.2lf\n", i, j, t);
			}
		}
	}
}

int main(int argc, char** args)
{
	HMM* hmm = makeHMM(STATE_END+3, 4);
	
	train(hmm, fopen("annotation1.fa","r"), fopen("genome1.fa","r"));
	//train(hmm, fopen("annotation2.fa","r"), fopen("genome2.fa","r"));
	//train(hmm, fopen("annotation3.fa","r"), fopen("genome3.fa","r"));
	
	
	
	printHMM(hmm);
}

