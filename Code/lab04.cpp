/*
 * @Description: 
 * @Version: 
 * @Author: Tyrion Huu
 * @Date: 2022-12-02 12:39:31
 * @LastEditors: Tyrion Huu
 * @LastEditTime: 2022-12-03 18:21:53
 */
#include <iostream>

using namespace std;

void SortAndCount2(int * in, int * & out, int &countA, int &countB)
{
    int i, j, temp;
    countA = 0;
    countB = 0;
    i = 15;
    while(i >= 0)
    {
        out[i] = in[i];
        i--;
    }
    for(i = 16; i > 0; i--)
    {
        for(j = 0; j < i; j++)
        {
            countA++;
            if(out[j] > out[j+1])
            {
                temp = out[j];
                out[j] = out[j+1];
                out[j+1] = temp;
                countB++;
            }
        }
    }
    for(i = 12; i < 16; i++)
    {
        if(out[i] >= 85)
        {
            countA++;
        }
        else if(out[i] >= 75)
        {
            countB++;
        }
        else
        {
            ;
        }
    }

    for(i = 8; i < 12; i++)
    {
        if(out[i] >= 75)
            countB++;
        else
            ;
    }
}

int main(void)
{
    int in[16] = { 85, 75, 95, 65, 55, 45, 35, 25, 15, 5, 95, 85, 75, 65, 55, 45 };
    int * out = new int [16];
    int countA, countB;
    SortAndCount2(in, out, countA, countB);
    cout << "The sorted array is: " << endl;
    for(int i = 0; i < 16; i++)
    {
        cout << out[i] << " ";
    }
    cout << endl;
    cout << "The number of students in the first group is: " << countA << endl;
    cout << "The number of students in the second group is: " << countB << endl;
    return 0;
}

void swap(int & a, int & b)
{
    int temp = a;
    a = b;
    b = temp;
}

