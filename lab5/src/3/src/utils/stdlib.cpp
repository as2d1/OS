#include "os_type.h"
#include <string.h>
template<typename T>
void swap(T &x, T &y) {
    T z = x;
    x = y;
    y = z;
}


void itos(char *numStr, uint32 num, uint32 mod) {
    // 只能转换2~26进制的整数
    if (mod < 2 || mod > 26 || num < 0) {
        return;
    }

    uint32 length, temp;

    // 进制转换
    length = 0;
    while(num) {
        temp = num % mod;
        num /= mod;
        numStr[length] = temp > 9 ? temp - 10 + 'A' : temp + '0';
        ++length;
    }

    // 特别处理num=0的情况
    if(!length) {
        numStr[0] = '0';
        ++length;
    }

    // 将字符串倒转，使得numStr[0]保存的是num的高位数字
    for(int i = 0, j = length - 1; i < j; ++i, --j) {
        swap(numStr[i], numStr[j]);
    }
    
    numStr[length] = '\0';
}

void ftos(char *str, double value, int precision){
    int a = (int) value;//整数部分
    double b = value - a;//小数部分

    itos(str, a, 10);

    int i = 0;
    while(str[i]!='\0'){
        i++;
    }
    str[i++] = '.';//小数点

    // 处理小数部分
    for(int j = 0; j < precision; j++){
        b *= 10;
        int digit = (int)b;
        str[i++] = digit + '0';
        b -= digit;
    }
    
    // 添加字符串结束符
    str[i] = '\0';
}
