#include<stdio.h> 
#include<stdlib.h>

# define Guimo 18
# define Total_step Guimo*Guimo // 
# define Row     Guimo          // 
# define Columns Guimo          // 
# define Drections 8            // 
# define x_0 9                  // 
# define y_0 9                  // 
# define jilu 0                 //
# define huanyou 1              // 

const int* par = 0;     // 
int times = 0;          // 
int deta_x[Drections] =     { 1,2,2,1,-1,-2,-2,-1 };
int deta_y[Drections] = { 2,1,-1,-2,-2,-1,1,2 };           // 
int sorted[Drections] = { 0,1,2,3,4,5,6,7 };                   // 
int qipan[Row][Columns];                                 // 
void print_result();                                     // 
int  check(int x_new, int y_new);                        // 
int  Find(int x, int y, int deep);                       // 
void sort_direction(int x, int y);                       // 
int  compare(const void* p1, const void* p2);            // 
void sort_index(const int ar[], int index[], int num);   // sort_direction 

int main() {
	// 
	for (int i = 0; i < Row; i++)
		for (int j = 0; j < Columns; j++)
			qipan[i][j] = 0;
	// 
	printf("-----------------------------------------------------\n");
	printf("-----------------------------------------\n");
	printf("----------------------------------:16070199012 \n\n");
	// 
	qipan[x_0 - 1][y_0 - 1] = 1;
	//  
	if (Find(x_0 - 1, y_0 - 1, 2) == 1)
		printf("\n!\n");
	else
		printf("\n!\n");
	return 1;
}
// print()  
void print_result()
{
	printf("\n");
	int i, j;
	for (i = 0; i < Row; i++) {
		for (j = 0; j < Columns; j++)
			printf("%4d", qipan[i][j]);
		printf("\n");
	}
}
// 
int check(int x_new, int y_new)
{
	if (x_new >= 0 && x_new < Row && y_new >= 0 && y_new < Columns && qipan[x_new][y_new] == 0)
		return 1;
	return 0;
}
// deep, Total_step=64 
int Find(int x, int y, int deep)
{
	if (x_0 == 1 && y_0 == 1) {
		if (deep <= Total_step - 1)
			qipan[2][1] = 1;
		else 		qipan[2][1] = 0;
	}
	if (x_0 == 1 && y_0 == Columns) {
		if (deep <= Total_step - 1)
			qipan[2][Columns-2] = 1;
		else  qipan[2][Columns - 2] = 0;
	}
	if (x_0 == Row && y_0 == Columns) {
		if (deep <= Total_step - 1)
			qipan[Row-3][Columns - 2] = 1;
		else  qipan[Row - 3][Columns - 2] = 0;
	}
	if (x_0 == Row && y_0 == 1) {
		if (deep <= Total_step - 1)
			qipan[Row - 2][2] = 1;
		else  qipan[Row - 2][ 2] = 0;
	}
	int i, x_new, y_new;
	sort_direction(x, y);                   // 
	for (i = 0; i < Drections; i++) {
		x_new = x + deta_x[sorted[i]];      // 
		y_new = y + deta_y[sorted[i]];
		int detax = abs(x_new - x_0 + 1);
		int detay = abs(y_new - y_0 + 1);
		if (check(x_new, y_new) == 1)       // a[xx][yy]  
		{
			qipan[x_new][y_new] = deep;
			if (jilu == 1) {
			if (deep == Total_step)         // 
				printf("%3d \n", ++times);
			}
			// 
			if (huanyou == 1) {
				if (deep >= Total_step && (detax*detax + detay*detay == 5)) {
					print_result();
					return 1;
				}
			}
			else {
				if (deep == Total_step) {
					print_result();
					return 1;
				}
			}
		
			if (Find(x_new, y_new, deep + 1) == 1)  // 1，。  
				return 1;
			else                                    // 1，，。  
				qipan[x_new][y_new] = 0;            // 
		}
	}
	return 0;
}
// 
void  sort_direction(int x, int y) {
	int x_new, y_new, xx_new, yy_new;
	int score[Drections] = { 8,8,8,8,8,8,8,8};           // 
	for (int i = 0; i < Drections; i++) {
		int count = 0;
		x_new = x + deta_x[i];
		y_new = y + deta_y[i];
		if (check(x_new, y_new) == 1) {           // a[xx][yy]  
			for (int j = 0; j < Drections; j++) {
				xx_new = x_new + deta_x[j];
				yy_new = y_new + deta_y[j];
				if (check(xx_new, yy_new) == 1)   // a[xx][yy]  
					count++;
			}
		}
		score[i] = count;
	}
	sort_index(score, sorted, Drections);                 // 
}
int compare(const void* p1, const void* p2)
{
	int a = *(int*)p1;
	int b = *(int*)p2;
	if (par[a] > par[b])
		return 1;
	else if (par[a] == par[b])
		return 0;
	else
		return -1;
}

void sort_index(const int ar[], int index[], int num)
{
	par = ar;
	qsort(index, num, sizeof(int), &compare);
}
