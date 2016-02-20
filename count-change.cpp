/***************************\
 * Author: Wang Hsutung
 * Date: 2016/02/08
 * Locale: Wuhan, Hubei
 * Email: hsu[AT]whu.edu.cn
\***************************/

#include <iostream>
#include <string>
#include <vector>
#include <cstdlib>

using namespace std;

int denomin[] = {0, 1, 5, 10, 25, 50};

int cc(int amount, int kind)
{
    if (amount == 0) {
        return 1;
    } else if (amount < 0 || kind == 0) {
        return 0;
    } else {
        return cc(amount, kind - 1)
             + cc(amount - denomin[kind], kind);
    }
}

int count_change(int amount)
{
    return cc(amount, 5);
}

int main(int argc, char *argv[])
{
    cout << count_change(100) << endl;
    exit(EXIT_SUCCESS);
}

