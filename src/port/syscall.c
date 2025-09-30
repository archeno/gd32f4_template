
#include <sys/stat.h>
#include <sys/types.h>

#ifndef __weak
#define __weak __attribute__((weak))
#endif

// Define caddr_t if not available
#ifndef _CADDR_T_DEFINED
typedef char *caddr_t;
#define _CADDR_T_DEFINED
#endif

// Forward declaration for UART function
__weak void uart_send_byte(unsigned char byte) { ; } // 这里换成你的串口发送函数

int _write(int fd, char *ptr, unsigned int len) {
  // 把输出重定向到串口/UART
  const char *p = (const char *)ptr;
  for (unsigned int i = 0; i < len; i++) {
    uart_send_byte(p[i]);
    // uart_send_char(p[i]);   // 这里换成你的串口发送函数
  }
  return (int)len;
}

caddr_t _sbrk(int incr) {
  extern char _heap_start; // 链接脚本里定义的堆起始地址
  static char *heap_end;
  char *prev_heap_end;

  if (heap_end == 0) {
    heap_end = &_heap_start;
  }
  prev_heap_end = heap_end;

  heap_end += incr;
  return (caddr_t)prev_heap_end;
}
