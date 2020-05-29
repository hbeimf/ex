#include <string.h>
#include <stdlib.h>
#include <stdio.h>

 
int add(int a, int b){
    // printf("hello world C!\n");
    return a+b;
}

// https://blog.csdn.net/earbao/article/details/51786510

//https://github.com/CurryGuy/lua-player-plus/blob/7cb0f6056ead933289cf7dacffd6ce54243630b7/lpp-c%2B%2B/Libs/strreplace.c
char * str_replace(const char *src, const char *from, const char *to)
{
	// printf("%s\n", src);
	// printf("%s\n", from);
	// printf("%s\n", to);

	// return src;

   size_t size    = strlen(src) + 1;
   size_t fromlen = strlen(from);
   size_t tolen   = strlen(to);
   char *value = malloc(size);
   char *dst = value;
   if ( value != NULL )
   {
      for ( ;; )
      {
         const char *match = strstr(src, from);
         if ( match != NULL )
         {
            size_t count = match - src;
            char *temp;
            size += tolen - fromlen;
            temp = realloc(value, size);
            if ( temp == NULL )
            {
               free(value);
               return NULL;
            }
            dst = temp + (dst - value);
            value = temp;
            memmove(dst, src, count);
            src += count;
            dst += count;
            memmove(dst, to, tolen);
            src += fromlen;
            dst += tolen;
         }
         else /* No match found. */
         {
            strcpy(dst, src);
            break;
         }
      }
   }
   // printf("%s\n", value);
   return value;
}
