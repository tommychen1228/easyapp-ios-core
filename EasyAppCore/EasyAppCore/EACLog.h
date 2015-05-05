#define EAC_LOG_D(context, message) NSLog(@"%@ <%@:%@:%d>", message, NSStringFromClass([context class]), NSStringFromSelector(_cmd), __LINE__)
#define EAC_LOG_E(context, message, ex) NSLog(@"%@ %@ <%@:%@:%d>", ex, message, NSStringFromClass([context class]), NSStringFromSelector(_cmd), __LINE__)
