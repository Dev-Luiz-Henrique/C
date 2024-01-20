// Dado um vetor w com 9 elementos inteiros e um inteiro i=5, represente os valores em w apos as seguintes atribuicoes:
//  w[0] = 17;
//  w[i/2] = 9;
//  w[2*i-2] = 95;
//  w[i-1] = w[8]/2;
//  w[i] = w[2];
//  w[i+1] = w[i]+ w[i-1];
//  w[w[2]-2] = 78;
//  w[1] = w[w[i]-1];

int w[9];
int i = 5;

w[0] = 17;        		// w: [17, ?, ?, ?, ?, ?, ?, ?, ?]
w[i/2] = 9;       		// w: [17, ?, 9, ?, ?, ?, ?, ?, ?]
w[2*i-2] = 95;    		// w: [17, ?, 9, ?, ?, ?, ?, ?, 95]
w[i-1] = w[8]/2;  		// w: [17, ?, 9, ?, 47, ?, ?, ?, 95]
w[i] = w[2];      		// w: [17, ?, 9, ?, 47, 9, ?, ?, 95]
w[i+1] = w[i]+ w[i-1];  // w: [17, ?, 9, ?, 47, 9, 56, ?, 95]
w[w[2]-2] = 78;   		// w: [17, ?, 9, ?, 47, 9, 56, 78, 95]
w[1] = w[w[i]-1]; 		// w: [17, 95, 9, ?, 47, 9, 56, 78, 95]

// Vetor final = w: [17, 95, 9, ?, 47, 9, 56, 78, 95]
